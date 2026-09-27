# FS106-V — the printed regular-class theorems, verified first-hand (sighted)

*Job FS106-V (de Bruijn), Opus 5.5, 2026-09-26. Brief `data/fs106/briefs/V106-verify-print.md` with `data/fs106/briefs/STANDING-RULES.md`
(read in full; rule 0 first: `CLAUDE.md` § The aim and § Counter-priors read from disk before anything else). The plan is
`plans/FS106-regular-half.md` (Stage 1 §1.2, Stage 5, Stage 6b read); the fixed claim list is `data/fs106/claims.md`. Grades are `CLAUDE.md` §
Notation's. Not blind; the blind verifier FS106-VB's record and directory are not opened before my verdict stage is committed. Working
files: `data/fs106/fs106-v/`; the exact check `tools/fs106_v_quotes.py`.*

## Theorems this phase proved

*(filled stage by stage; one line each, grade and address)*

## Would-have-searched-here log

- Stage 1: none (reading and a quotation check).

## Stage 1 — SAVED: quotation check and reading plan

### 1.1 Quotation check (standing rule 5)

**Instrument.** `tools/fs106_v_quotes.py <file> --src … [--plant]`: every straight-quoted string of at least 12 characters is split at
ellipses and each piece must occur, whitespace deleted and line-end hyphens joined, in the named sources (the PDFs through
`pdftotext -layout`, repository files as they are). A miss prints the longest prefix that does occur, so a garbled symbol is told apart
from a changed word. **Plant:** `--plant` mutates one present quote (its longest word reversed) and adds one invented sentence; both must
read MISS while the untouched quote still reads OK. Run on `data/fs106/claims.md` against the Voronov and Sokolov–Voronov PDFs, the
Townsend 1981 scan, `plans/FS103-M-derivation.md`, `plans/FS103-N-verification.md`, `data/fs103/claims.md`, `LEDGER.md`, `CLAUDE.md`:
**60 pieces, 53 verbatim, 7 misses; the plant fired** (`fired=True`). The first run misread the list (a length floor inside the regex
shifted the quote pairing after the six-letter quote "proper", and line-end hyphenation — "multi-\ncolor" — broke four S–V quotes); both
were instrument defects, repaired before the reading below, and the second run is the one recorded.

| claim | quotation | verdict |
|---|---|---|
| D-NORM, D-VPROP, D-VMC, V-1.1, V-1.2, V-1.3, V-2.1, V-2.2, V-P2.2, V-4.1, V-6.1 | `[Voronov2023]` v3 | **verbatim** (every piece) |
| D-SV Conditions 1–8, Definition 2; SV-1, SV-2, SV-L1, SV-C2, SV-C3, SV-L3, SV-L4; C-AE-Q2's Question 2; C-Q-STAB's §9 sentence | `[SokolovVoronov2025]` v1 | **verbatim** (four matched only after joining line-end hyphens: the PDF's own hyphenation) |
| D-M, D-CP, I-D1, I-D2, I-D4, I-M1, I-EASY | FS-103's records, `LEDGER.md` row 130 | **verbatim** |
| I-CE | `[CurrieEggleton2016]` as quoted in `plans/FS103-M-derivation.md` D5 | verbatim against that quotation (the paper itself not re-opened) |
| TW-81 theorem | `[Townsend1981]` p. 114 | **verbatim** |
| TW-81 lemma | p. 115; the text layer garbles "A°" as "A”"/"A0" and the constant as "43" | **checked against the scan** (rendered at 150 dpi): "LEMMA. Let A° be a finitely disconnected unit annulus for which the unit circle contained in its closure, A, has at least one segment of length greater than π/3 containing no cut points of A. Then any 2-colouring of A° contains a monochrome unit." — **the constant is π/3**; the list's text otherwise matches |
| C-T-TAN, C-Q-STAB (the advisor's wordings) | FS106-A | **not on disk verbatim**: `plans/POROS-2026-09-26-fs106-regular-half.md` l. 52 carries the tangent form in other words ("blows up to "same projection onto the joining direction"") and l. 188 the stability form ("colours plus a free seventh of density ≤ δ"); the quoted wordings are from a message. Unverifiable here; not load-bearing for this job (neither is a claim I verdict) |
| C-Q-STAB's `[Parts2020c]` quote | "more than 99.985698% of the Euclidean plane" | **verbatim** against arXiv:2010.12668v1 (abstract page and PDF, fetched today) |
| C-ROW40's row-40 quote | `LEDGER.md` row 40 | verbatim modulo bold markup ("**conditional on** `[Voronov2023]` Thm 1.1 and `[SokolovVoronov2025]`") |
| C-AE-MAP6's "boundaries of measure 0" | — | the list's own words, not a quotation |

**Two corrections found on the way (not in my brief; owed elsewhere):**
- `plans/FS106-regular-half.md` §1.1 Q7 quotes `[Townsend1981]` p. 115 as "need care and attention to line detail"; the scan reads **"need care
  and attention to fine detail, requiring about two hundred lines of argument altogether."** A text-layer garble carried into a quotation.
- The same note (p. 114) quotes Woodall's assertion with **"length L greater than or equal to ⅔π"** and the counterexample **"when L = ⅔π"**, the
  sector "subtended by the angle ⅔π" (the text layer prints "5~" and "f7c"; the scan is unambiguous). Recorded here because TW-81's reading in
  stage 5 needs it.

**My brief's own statements, checked.** The brief quotes no source verbatim; its glosses were checked against the papers: band-avoiding (V-1.1),
closed (V-1.3), polygonal and map-type under conditions (SV-2, SV-1) — **match**. "maps need six (`[Townsend1981]` states it; its proof is
`[Townsend2005]`'s)" — **half checked**: Townsend 1981 states the theorem as **Woodall's** ("Woodall's result may then be stated in the terms of the
following theorem"), says Woodall's proof rests on a false assertion, and announces a proof by a replacement lemma without giving it ("The proofs
… need care and attention to fine detail"); that the proof is Townsend 2005's is `[SokolovVoronov2025]` p. 2's attribution ("In [12, 10] … it is
possible to show that 6 ≤ χmap (R2 ) ≤ 7", [12] = Woodall 1973, [10] = Townsend 2005), unverified until Townsend 2005 lands.

A side slip of mine, logged: the first extraction wrote five `*.txt` files into the shared harness scratchpad's root (not my subdirectory)
under names another job may have used; the contents are `pdftotext -layout` of the same PDFs. My copies now live in my own subdirectory.

### 1.2 Reading plan and status at the start

| key | copy | status before this job | plan |
|---|---|---|---|
| `[Voronov2023]` | `~/source/library/pdf/arXiv-2304.10163-voronov.pdf` (v3, 13 Apr 2025, 16 pp.) | read 2026-09-08 (FS-18), 2026-09-26 (FS106-P, skeleton) | **read in full today** (stage 1); verified step by step in stage 2 |
| `[SokolovVoronov2025]` | `…/pdf/arXiv-2502.01958-maptype.pdf` (v1, 4 Feb 2025, 29 pp.) | read for the cell family (FS-18), §§4–9 (FS106-P) | **read in full today** incl. the Appendix; verified in stage 3 |
| `[Townsend1981]` | `~/source/library/papers/townsend-1981-every-5-coloured-map-monochrome-unit-jcta-30-114-115.pdf` | read (FS106-P) | **read in full from the scan** (stage 1); TW-81 in stage 5 |
| `[Coulson2004]` | `…/pdf/jams-2004-coulson-chromatic-number-plane-tilings.pdf` | held | stage 5 |
| `[Woodall1973]` | `…/pdf/jcta-1973-woodall-distances-realized-covering-plane.pdf` | held | stage 5 |
| `[Parts2020c]` | arXiv:2010.12668v1 (fetched today to my scratch; 15 pp.) | not held (`BIBLIOGRAPHY.md`: "second-hand") | abstract and §1 read today; stage 5 |
| `[Townsend2005]`, `[Thomassen1999]`, `[Pritikin1998]` | not held; Kooshi fetching | second-hand | read when the owner relays them |

## Stage 1 — SAVED
