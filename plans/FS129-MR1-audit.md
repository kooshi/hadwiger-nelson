# FS129-MR1 — pass 2 of the cross-application audit, lane R (the regularity-wall era): mechanisms, the record

*Ephodos, the deriver (read as files, by Kooshi's decision 2), as a `general-purpose` agent on Opus. Brief:
`data/fs129/briefs/FS129-MR1-pass2.md`. Plan: `plans/FS129-cross-application-audit.md` § 3, Stage 3. Lane R owns the grokkings G2, G3,
G81–G86, G88–G91 (`plans/FS129-close-inventory.md` item 51) and the mechanisms named in its held results; this pass follows each to every place
it bears across the whole corpus, both eras. Writes only this file, `data/fs129/mr1/`, `tools/fs129_mr1_*.py` and
`data/fs129/reports/FS129-MR1.md`. Started 2026-10-03 23:48 UTC.*

## Theorems this phase proved

(Filled at the close of the pass.)

## Stage 1 — SAVED: readback and registered expectations

**Readback.** Read in full before this stage: the brief; `.claude/skills/ephodos/SKILL.md`; `.claude/agents/ephodos.md` from
`# Ephodos in lean-dir — the workflow` to its end; `plans/STANDING-RULES.md`; `plans/FS129-cross-application-audit.md`;
`plans/STUB-cross-application-audit.md`; `data/fs129/demand-judged.md` (all of it — § 1's homonyms are required before the first mechanism);
`plans/FS129-OR1-audit.md` (all of it, lane R's pass 1); the reports `data/fs129/reports/FS129-OR1.md` and `-OA1.md`; inventory items 51,
54–65 of `plans/FS129-close-inventory.md`; items 122, 124, 127, 136, 142, 150 of `plans/FS116-close-inventory.md`; and
`plans/FS116-V6-verification.md` ll. 120–200 (§ 2.2, V6-WIN to V6-EMPTY, to check the brief's pointer to the V6-HUG display). Not yet read
(on purpose, until these expectations are saved): any grokking, the index's tables, the derivation files.

**Quotation check** (standing rule 3), by script, character for character:
- the request (`> Right after this close, …`) against `plans/STUB-cross-application-audit.md`: found, verbatim;
- decisions 1–4 (`> 1. yes, we don't want O(N^2) here. …`) against `plans/FS129-cross-application-audit.md`: found, verbatim;
- the note on roots (`> Also a note for the whole plan …`) against the same file: found, verbatim;
- the brief's pointer "displayed at line 159 of `plans/FS116-V6-verification.md` § 2.2": line 159 is the display
  `$$|a(s) − b(t)|^2 − 1 = −8 \sin\tfrac{s}{2}\,\sin\tfrac{t}{2}\,\cos\tfrac{s+t}{2} < 0 \quad (0 < s, t \le 60°)$$`, inside § 2.2
  (which starts at l. 102), with `a(s) = y_0 + e(120° + s)` and `b(t) = y_1 + e(300° − t)` defined at ll. 150–157 (`p = 0`, `y_k = r(60°k)`);
- Kooshi's question, "where else can we use that identity?", against `plans/FS116-close-inventory.md` item 142: found, verbatim, inside
  "That's an interesting one. How did the original proof do it, and where else can we use that identity?".

No mismatch; no finding about the brief. One note for my own reading: item 150 records that Poros's R2 already answered Kooshi's question in
part — card 2 of `plans/POROS-2026-10-03-close-reread.md` names the identity as the classical three-unit-step closure
`|u + v + w|² − 1 = (u + v)(v + w)(w + u)/(uvw)`, with "four configurations ranked". My pass reads that card before working the identity, and
does not redo what it closed.

**Registered expectations** (2026-10-03 23:48 UTC, before any grokking, index table or derivation file was read for this pass; scored at the
close of this pass; instruments for G21, never caps):

| quantity | expectation | reasoning |
|---|---|---|
| mechanisms worked (12 grokkings + the bends + two closed forms + pass 1's four leads, counted once each) | about 16, of which I expect to finish 11–16 inside the budget | five mechanisms are named in the brief's order; the rest by reach |
| mechanisms that bear somewhere **unapplied** (a composition, a miss or a near miss with a named failing hypothesis) | 6 (range 3–9) | pass 1 found two in-era misses in one pass over 24 steps; mechanism-first reading meets more sites per mechanism |
| **compositions derived** (block entries) | 4 (range 2–8) | pass 1 derived 8 against a registered 3; I correct upward for that miss, downward because pass 1 took the richest ones |
| **misses of the FS116-Y4 kind** (a milestone worked a step the mechanism would have shortened or emptied) | 2 (range 0–4) | G83's straddle and the bends are both mechanisms that empty classes; each was applied late at least once |
| nulls (mechanisms that bear nowhere new) | 5 (range 2–9) | |
| G83's straddle bears on a held entry's step that it was not applied to | P = 0.55 | the prompting instance was one; straddles are cheap to check |
| the bends (in BEND3's generality) shorten an FS110-era GAP (FS110-A3-HOLE or FS110-N2-SWAP) | P = 0.45 | their reading radius is unknown to me; √3 is generous for a local step, tight for a radius-2 step |
| V6-HUG's identity closes or empties a held open step (not only re-derives a held kill) | P = 0.20 | R2's card 2 already ranked its configurations; what is left is the harder sites |
| a held result found false as read (a refutation to message the coordinator about) | P = 0.04 | |
| this pass **changes the bearing on the answer** (a step of FS-123, FS-124, FS-125, FS-104 or the map step closed or reduced so that a route's shape changes) | P = 0.10 | pass 1 took the top step; pass 2 is interweaving |
