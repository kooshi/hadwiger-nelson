# FS106-VB — blind verification of the printed regular-class theorems, and a second mind on three held lemmas

*Job FS106-VB (Coxeter, verifier), Opus 5.5, 2026-09-26. Brief: `data/fs106/briefs/VB106-blind-print.md` with
`data/fs106/briefs/STANDING-RULES.md`. **Blind**: nothing on the brief's fence list is opened before stage 5 is committed. Working
text layers (`pdftotext -layout` of the three papers, page renders of the Townsend scan) live in my own subdirectory of the harness
scratchpad, `…/scratchpad/fs106-vb/`; nothing else in that scratchpad was opened.*

## Theorems this phase proved

*(filled at stage 5; one line per theorem, grade and address)*

## Stage 1 — SAVED

### 1a. Standing rules read

`CLAUDE.md` § The aim and § Counter-priors read from disk first (rule 0); `STANDING-RULES.md` read in full; the claim list
`data/fs106/claims.md` read in full. Message from main mid-stage: `[Thomassen1999]` is now held as text
(`~/source/library/papers/Thomassen-1999-On-the-Nelson-unit-distance-coloring-problem.txt`); it is not among this job's claims (TH-99 is the
reading job's), so it is noted here and read only if budget allows after stage 4.

### 1b. Quotation check (standing rule 5)

Tool: `tools/fs106_vb_quotes.py <dir of text layers>` — pulls every quotation from the claim-list entries this job verifies, splits at
"…", deletes whitespace, de-hyphenates line breaks, and looks each fragment up in the paper's text layer. Result: **40 of 40 fragments
found** across D-NORM, D-VPROP, D-VMC, D-SV, V-1.1 … V-6.1, SV-1, SV-2, SV-L1, SV-C2, SV-C3, SV-L3, SV-L4, TW-81, C-T-CHR4, C-T-IND,
C-AE-Q2, C-Q-STAB (§9 part). Four caught fragments are not quotations of these papers (the list's own quote marks, FS106-A's wording,
`[Parts2020c]`'s abstract) and are excluded by name in the tool. Controls: two planted misquotations are refused (exit 0 requires it);
a planted fault in a copy of the Voronov layer ("covered by 5 closed sets") turns the check red on V-1.3 alone (exit 1), for its own reason.

- **TW-81's garbled constant, read from the scan** (`tw-2.png`, p. 115): the lemma's constant is **π/3** — "at least one segment of length
  greater than π/3 containing no cut points of A". The scan also shows the note's counterexample to Woodall's assertion is at
  "L = ⅔π" (p. 114), and the note's own "A°" (the text layer reads "A”"/"A0").
- **Deferred to stage 6** (the sources are fenced): I-D1, I-D2, I-D4 and D-NF's "held" sentence are quoted from
  `plans/FS103-M-derivation.md`, fenced for this job; I-CE is quoted via the same file. They are checked against their sources at stage 6.
- Brief's own quotations: the brief quotes nothing verbatim beyond pointers to the claim list; nothing further to check.

### 1c. Expectations, registered before any derivation

*Honest order: Voronov's paper had been read in full (to check quotations) before this registration; S–V and Townsend's lemma text had
been read only at the quoted statements.* Probability that my verdict will be TRUE (proof as printed correct, possibly after local repairs
I can name); otherwise the expected failure shape.

| claim | P(TRUE) | expected shape if not |
|---|---|---|
| V-1.1 | 0.75 | GAP in the passage discrete → trichromatic structure (recolourings) |
| V-1.2 | 0.8 | GAP at the arc bookkeeping of the index argument |
| V-1.3 | 0.8 | GAP only if V-1.1's localisation to radius 3 leaks |
| V-2.1 | 0.97 | — |
| V-2.2 | 0.85 | GAP: limit taken in a recoloured discrete colouring |
| V-P2.2 | 0.95 | — |
| V-4.1 | 0.9 | sign slip only |
| V-6.1 | 0.7 | GAP at the extension of boundaries / the ten-point step |
| SV-1 | 0.55 | GAP in the case analysis around vertices / tangencies |
| SV-2 | 0.6 | GAP at the reduction of polygons to Conditions 5–6 (bowtie vertices) |
| SV-L1 | 0.6 | GAP at non-smooth boundary points |
| SV-C2 | 0.6 | GAP at the construction of the covering arcs |
| SV-C3 | 0.65 | — |
| SV-L3 | 0.55 | — |
| SV-L4 | 0.55 | — |
| TW-81 | n/a | **no proof printed**: a verdict on the proof must be "no proof to check"; the statement's truth rests on later literature |
| C-CS-1 | 0.85 | MISSTATED at the word "equivalent" (a step is not a statement) |
| C-CS-2 | 0.95 | — |
| I-D1 | 0.95 | — |
| I-D2 | 0.97 | — |
| I-D4 | 0.95 | endpoint of the slack interval |
| D-NF density statement | 0.95 | — (a corollary of I-D1) |

### 1d. Controls

1. **The tight hexagonal 7-colouring must survive every seven-colour claim.** For each "needs 7" proof I name the step where the count six
   enters and check that the same step fails for the hexagonal 7-colouring (hexagons of diameter just under 1, same-colour hexagons more
   than 1 apart). A proof step that would also refute the 7-colouring is a defect.
2. **Exact distance against a band.** For each step I record whether it uses the forbidden *interval* (slack), *closedness*, or *the colour
   of a boundary point*; a step that uses slack and is then claimed at exact distance is a defect.
3. **Known facts as calibration:** the unit circle's exact-unit-distance graph is 2-colourable (6-cycles), so any argument that proves the
   bicycle needs four colours must use the band somewhere; I locate where.

### 1e. "Would have searched here" log

- none so far.
