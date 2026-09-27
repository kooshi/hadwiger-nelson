# FS106-SB — blind second mind on FS106-TS's verdicts (Coxeter, verifier)

*Job FS106-SB, 2026-09-27. Brief: `data/fs106/briefs/B106-blind-second.md`; instance sheet `data/fs106/briefs/SB106-instance.md`; standing rules
`data/fs106/briefs/STANDING-RULES.md`. Blind: nothing fenced opened before stage 3 is committed. Papers read first-hand from their text layers
(`pdftotext -layout`): `[SokolovVoronov2025]` (arXiv:2502.01958v1, all 29 pp.), `[Coulson2004]` (J. Aust. Math. Soc. 77, pp. 191–196, all),
`[Voronov2023]` §6 (Lemma 6.1 and its proof, pp. 12–13 of arXiv:2304.10163) only.*

## Theorems this phase proved

*(filled at stage 3)*

## Stage 1 — SAVED

### 1.1 Quotation check (standing rule 5)

| quoted in | text | source | result |
|---|---|---|---|
| sheet item 1 | "No polygonal colouring (D-SV Condition 8) with 6 colours is a.e.-proper (D-AEMAP)." | `data/fs106/claims.md` l. 119 | verbatim ✓ |
| sheet item 2 | "seven colours for locally finite convex tilings, almost everywhere" | said to be at `claims.md` l. 127 | **not there.** l. 127 states no theorem: "the a.e. forms of `[Thomassen1999]`'s nice-map theorem and `[Coulson2004]`'s convex-tiling theorem, stated by the reading job in this list's form … once the printed statements are quoted". The reading job's statement is fenced. **And `[Coulson2004]`'s printed theorem is six, not seven**: Thm 3.5, p. 196, "A tile based colouring with excluded distance D must employ at least 6 colours." So "seven for convex tilings" is not the a.e. form of Coulson's theorem; it is SV-2 restricted to tilings. I verify the sheet's gloss, with my own precise statement (§2.2). |
| sheet item 3 | original wording of C-T-IND | `claims.md` l. 146–148 | the sheet's pointer ✓; the quoted S–V Prop. 12, "If γ1 ∼ γ2 , then \| Ind γ1 − Ind γ2 \| ≤ 1.", matches the text layer (p. 15) ✓. The corrected form is the deriver's; its source is fenced, so it is taken as the sheet gives it. |
| sheet items 4–8 | TS-C, TS-T, TS-U, TS-L1, C5 | the deriver's list (fenced) | cannot be checked against source until stage 4; taken as the sheet gives them. "SV-L4 (a)": `[SokolovVoronov2025]` Lemma 4 (p. 19) has no labelled step (a); I read it as the first sentence of Lemma 4's discussion, p. 20: "It is straightforward to verify that within a distance of at most 1 from any point, there exists a trichromatic point." |
| claims.md D-SV | Conditions 1–8, Definition 2 | S–V pp. 3–4 | verbatim ✓ (symbols as in the text layer) |
| claims.md SV-L1, SV-L4, SV-2, SV-C3 | as quoted | S–V pp. 5, 6, 14, 19 | verbatim ✓ |
| brief | "Given MR, Hadwiger–Nelson is whether a tight, non-closed measurable colouring …" | `CLAUDE.md` § The aim, link 5 | a gloss, not in quotation marks; faithful to link 5 ✓ |

Two defects of the printed S–V text noticed while checking (not quotations of the brief): Theorem 2's proof cites "Lemma 8" (p. 25), which is
Proposition 8 (p. 10); and S–V's appendix (p. 28) speaks of "the union of three regions of colors 1, 2, 3 whose vertex is u", where `u` has
multicolour {4, 5, 6} — the colours are 4, 5, 6 (§2.1, step A11).

### 1.2 Expectations, registered before the derivations were written

Honest timing: registered after reading the three papers and a first pass of thought, before any derivation was written down.

| claim | expectation | confidence | the control |
|---|---|---|---|
| C-AE-POLY | TRUE: S–V's argument is local and uses multicolours; the three places that use a colour at a boundary point (Lemma 1, Prop. 7, Prop. 12 at a swap) can be repaired | medium | point each repaired step at a configuration where the printed step's conclusion is known false without its hypothesis (C5's configuration for Prop. 5) |
| C-AE-CONV | TRUE as a corollary of C-AE-POLY | medium-low: merged tiles need not be polygons in S–V's sense | the tile-to-map conversion checked against Conditions 2–4, 8 one by one |
| C-T-IND (corrected) | mixed: the bound is TRUE given no swap; the "iff" is definition-dependent | medium | an explicit trace with infinitely many changes, lifted by hand |
| TS-C | TRUE | high | a two-region chain touching at a vertex, done by hand |
| TS-T | TRUE | medium-high | the Lebesgue covering theorem's hypothesis checked against diameter ≤ 1 |
| TS-U | TRUE with the wedge made exact (second order) | medium | the sampling check of C5 plants a colour in a side cone and must go red |
| TS-L1 | TRUE, by a countability argument on circles, with local finiteness | medium-high | the argument must fail where local finiteness fails (checked by naming the step) |
| C5 | TRUE: a configuration exists; I expect it to need an extra colour pair in the two side cones at `y` | medium | `tools/fs106_sb_c5_check.py`, with a plant that must fire |

### 1.3 Would have searched here

- C5: would have asked a solver for local colourings of two unit-spaced discs meeting the pair constraints. Instead: constructed by hand
  from the second-order unit-arc analysis, then checked by a seconds-long exact-geometry sampling script (a check of a derived claim, not a search).
