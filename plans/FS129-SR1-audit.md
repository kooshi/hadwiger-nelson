# FS129-SR1 — pass 3 of the cross-application audit, lane R (the regularity-wall era): merges, strengthening, vacuity, the records that disagree

*Ephodos, the deriver (read as files, by Kooshi's decision 2), as a `general-purpose` agent on Opus. Brief:
`data/fs129/briefs/FS129-SR1-pass3.md`. Plan: `plans/FS129-cross-application-audit.md` § 3, Stage 4, scoped first to the Lean order
(`data/fs129/index/lean-order.md`). Writes only this file, `data/fs129/sr1/`, `tools/fs129_sr1_*.py` and `data/fs129/reports/FS129-SR1.md`.
Started 2026-10-04 00:15 UTC. Planned as successive agents: this one works the named items, then the vacuity sort, then the sweep, and hands
the rest to FS129-SR2.*

## Theorems this phase proved

*Filled at each stage; see the last line of this section for the current state.*

- (none yet)

## Stage 1 — SAVED: readback and registered expectations

**Readback.** Read in full before this stage: the brief; `.claude/skills/ephodos/SKILL.md`; `.claude/agents/ephodos.md` from
`# Ephodos in lean-dir — the workflow` to its end (lines 278–432 read; `## The record job` not mine); `plans/STANDING-RULES.md`;
`plans/FS129-cross-application-audit.md`; `plans/FS129-close-inventory.md` (all 85 items); `data/fs129/index/lean-order.md` (all 197 rows);
`data/fs129/index/vacuity.md` (the header, the two lists and the 55 `none-known` entries' model lines). Not yet read, on purpose, until these
expectations are saved: any derivation file, any grokking, passes 1 and 2's records beyond MR1's first 60 lines (read for the record's form).

**Quotation check** (standing rule 3), by script:
- the request (`> Right after this close, …`) against `plans/STUB-cross-application-audit.md`: found, verbatim (`grep -cF` → 1);
- decisions 1–4 (`> 1. yes, we don't want O(N^2) here. …`) against `plans/FS129-cross-application-audit.md`: found, verbatim;
- the note on roots (`> Also a note for the whole plan …`) against the same file: found, verbatim;
- Kooshi's reading (`> **Kooshi's reading** (2026-10-03, verbatim): "Oh... oh I see. …`) against `plans/FS129-close-inventory.md` § Items:
  found, verbatim, as item 32, across its line breaks (a single-line `grep -F` misses it; joined on whitespace it matches).

No mismatch; no finding about the brief.

**Scope, counted before reading.** The Lean order holds 197 results; 195 are lane R's (FS-106, FS-111, FS-112, FS-114, FS-116, FS-121), and 2
lane A's (TC1-SQRT3-DYADIC, TC1-STANDING-FIVE, both conditional seeds, item 13) — those two are lane A's pass 3's, and I leave them. The
vacuity file flags 55 `none-known` entries, every one of them lane R's (FS-114, FS-116, FS-121), plus a second list of 2 borderline and 16
loose-pattern entries.

**Registered expectations** (2026-10-04 00:15 UTC, before any derivation file or grokking was read for this pass; scored at this pass's hand-back
and at FS129-Z1; instruments for G21, never caps):

| quantity | expectation | reasoning |
|---|---|---|
| of the seven named merge groups (brief § Done means 2(c)), confirmed as **one statement or one a case of the other** | 5 of 7 (range 3–7) | each was flagged by a reader who had both statements open; the stuck ray / tangent pencil and RINGWIND / FS110-Y3-GP groups read as shared mechanisms more than shared statements |
| further merges found in the sweep of the Lean order (beyond the named groups) | 8 (range 3–15) | FS-116's V-stages re-derive its Y-stages (V5-U1, V5-NE1 already flagged); FS-114 holds superseded entries kept "as the proof side's route" |
| hypotheses weakened, the weaker form derived as an entry | 3 (range 1–8) | item 61 (bends need one absent side colour) is one ready; most hand results here are already stated at the class their argument used |
| of the 55 `none-known` entries: **hypothetical by design** / **no-go** / **empty** / **inhabited** | 38 / 7 / 6 / 4 | FS-116's Y3–Y4 and V5–V6 lists and FS-121's D1–D2 lists are steps toward a contradiction; Y4-EMPTY, Y4-OBST, D4-HOLE, TIGHTLENS read as no-gos; FS114-N7-HUB already says it is "true vacuously" on one class |
| an "empty" entry with a dependent that **inherits** the vacuity in a way that matters (a non-contradiction use of an empty class) | P = 0.30 | the double tip was worked two rounds on an empty class; the danger is a construction-side use |
| the disagreement on FS-112's bends (item 2(b)) **settled by pass 1's WHOLE** | P = 0.55 | WHOLE is a whole-tile restriction statement; the disagreement may be about round versus whole-tile restriction, which WHOLE addresses, or about which arcs survive, which it may not |
| the attack on FS129-OR1-QFREE's chain (item 55) **succeeds** (a step fails as stated) | P = 0.15 | horn lenses at cusp ends are the kind of place a simplicity hypothesis breaks |
| the attack on FS129-MR1-DOUBLETIP (item 76) **succeeds** | P = 0.15 | "free only because its neighbour is a change point" is a circular-looking step, but RING-GERM's germs are local |
| either attack yields a **repair** narrower than the stated composition, rather than a refutation | P = 0.25 | |
| pass 3 finds **a held result false** (any, including the two compositions) | P = 0.22 | |
| of the lane-R "Rests on it: nothing" edges (item 77), the share that are **real** dependencies | 30 % | the examples given are mostly corrected-form pointers and successor lists |
| this agent reaches the end of the vacuity sort before handing back | P = 0.6 | the named items are heavy reading; the sweep goes to SR2 |
