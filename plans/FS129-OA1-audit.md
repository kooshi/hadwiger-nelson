# FS129-OA1 — pass 1 of the cross-application audit, lane A (the arithmetic era): the record

*Job FS129-OA1, brief `data/fs129/briefs/FS129-OA1-pass1.md`; a `general-purpose` agent on Opus reading Ephodos's identity
(`.claude/skills/ephodos/SKILL.md`, then `.claude/agents/ephodos.md` from `# Ephodos in lean-dir — the workflow`). Plan:
`plans/FS129-cross-application-audit.md` § 3 Stage 2. Writes only this file, `data/fs129/oa1/`, `tools/fs129_oa1_*.py` and
`data/fs129/reports/FS129-OA1.md`.*

## Theorems this phase proved

None yet (filled at the last stage).

## Stage 1 — SAVED (readback, registered expectations)

### 1.1 Readback of the brief's quotations (standing rule 3)

Checked by `grep -cF` of each quotation, character for character, against the source the brief names (2026-10-03 23:10 UTC):

| quotation | source named | found |
|---|---|---|
| "Right after this close, we'll be refining the workflow again... File that as a special case stub for after the workflow refinements." (full text) | `plans/STUB-cross-application-audit.md` § The request | 1 — verbatim |
| "1. yes, we don't want O(N^2) here. 2. Yes, keep to the cap, … so it'll pick up the latest changes." (full text) | `plans/FS129-cross-application-audit.md` § 1 | 1 — verbatim |
| "Also a note for the whole plan that not only are "hubs" important, but deep "roots", … even if it has only one offshoot" (full text) | `plans/FS129-cross-application-audit.md` § 1 | 1 — verbatim |

No mismatch. The brief's references to the inventory (items 11, 19, 20, 23, 24, 25) were read against `plans/FS129-close-inventory.md`;
each says what the brief says it says.

### 1.2 What I read before registering

The brief; the identity and the lane workflow's `## Where you sit`, `## A derivation job`, `## What leaves your lane`;
`plans/STANDING-RULES.md`; the plan; the inventory; and the stub in full — **including Poros's bearing paragraph, which names J1–J4,
J10 and the two lane-A sites of decision 4 (TOP₆'s coverage; FS-104's correlation route) by their headlines**. I had not opened
`data/fs129/demand-judged.md`, the index, or any derivation file when I wrote § 1.3. So the registration below is blind to the list's
steps except for those five headlines.

### 1.3 Registered expectations (before reading the demand list; scored at FS129-Z1)

My prior on the mechanism: lane A's results are algebraic and discrete — residue colourings, finite planes, field towers, forced pairs
in finite graphs, measure rigidity for the unit-vector group. The demand list is regularity-era: local geometry of colour classes near a
point, unit arcs, saturation, a CP colouring's correlations. The two eras meet in at most three places I can name in advance: (i)
anything that speaks of a colouring of one unit circle (a fan, coverage — G13) is local and era-free; (ii) the compulsion toolkit
(forced pairs, virtual edges) speaks of every proper k-colouring of a finite graph, and every finite unit-distance graph embeds in the
plane, so it constrains a measurable colouring wherever the graph is "seen" almost surely (row 130's random-motion argument); (iii)
measure rigidity and the collapse are already the bridge (rows 120, 128, 130), and the stub cites them.

| id | expectation | value |
|---|---|---|
| OA1-E1 | steps closed by a lane-A composition | expected 0; P(≥ 1) = 0.10 |
| OA1-E2 | steps shortened (a named case closed, a hypothesis removed) or reduced to another step by a lane-A composition | expected 1.5; P(≥ 1) = 0.55; P(≥ 3) = 0.15 |
| OA1-E3 | nulls ("no lane-A result bears") among the steps I reach | expected about 85 % of the steps reached |
| OA1-E4 | this lane moves the bearing on the answer (changes `CLAUDE.md` § Where the problem stands item 31's open list or the top three) | P = 0.07 |
| OA1-E5 | lane A closes or shortens a regularity-era step from a result its stub does not cite (Poros's A5, registered at 0.35) | P = 0.30 |
| OA1-E6 | a held lane-A result found false on reading | P = 0.03 |
| OA1-E7 | a composition outside the demand list, recorded for pass 2 | expected 1; P(≥ 1) = 0.5 |
| OA1-E8 | merges and new stubs from this pass (pass 1 is not the merge pass) | merges 0; new stubs expected 0.3 |
| OA1-E9 | the site most likely to yield, of Poros's four (J4, J12–J13, J2, J17) | J4 (TOP₆ as coverage, G13), P(it yields a shortening or reduction) = 0.3 |
