*Brief for job **FS114-Y4**, the construction side of FS-114 (the unit-arc question), round 4. Opus 5.5. Written by the product owner, 2026-09-28.
**Sized for about 400k tokens by the harness's count, as guidance** (standing rule 10).*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **Your brief is FS114-Y's, `data/fs114/briefs/Y114-construction.md`, plus
the cards `ROUND2-card.md`, `ROUND3-card.md` and `ROUND4-card.md` in `data/fs114/briefs/`, plus this file; where they differ, this file wins, then the
round-4 card.** Read `data/fs114/briefs/STANDING-RULES.md` in full, rule 0 first.

## What changes

- **Read first:** the three cards; then `plans/FS114-Y3-construction.md` in full (round 3: RSTOP, R, D2, FOUR, 13, and its list of what is left) with
  `tools/fs114_y3_*` and `data/fs114/fs114-y3/`; `plans/FS114-Y2-construction.md`; `plans/FS114-YB2-verification.md` (the blind rebuild of the bowtie,
  YB2-EMPTY13, YB2-DE; its tools `tools/fs114_yb2_*` are open to you and its checker may be run unedited); `plans/FS114-L60-audit.md` (L60 corrected).
- **Your record** is `plans/FS114-Y4-construction.md` (the usual headings; SAVED stages). Working files go in `data/fs114/fs114-y4/`, tools in
  `tools/fs114_y4_*.py`, the report in `data/fs114/reports/FS114-Y4.md`. Commit subjects are "FS114-Y4: stage n".
- **Fences:** FS114-Y's, plus every proof-side record, directory and tool (`plans/FS114-N*-proof.md`, `data/fs114/fs114-n*/`, `tools/fs114_n*`),
  including the proof verifiers' (`plans/FS114-NB*`, `data/fs114/fs114-nb*/`); FS-111's files. The cards give the other side's results.

## Your side, round 4: the escapes

Objects by formula, checked exactly by a calibrated checker (YB's or YB2's, unedited, beside yours, which must accept the five controls first); every stop
read as a statement about every valid map (G79) and sent to the owner at once. Each stage is SAVED and committed.
1. **The escapes from RSTOP.**
   - Build a Reuleaux bowtie fragment that contains a neighbourhood of `r = (√3, 0)` through E1 or E2 (the round-4 card), asymmetric if it must be.
   - Or derive that E1 and E2 are both impossible, which extends RSTOP to every bowtie.
   - Start with Y2's x-action with `y ↦ −y` acting as `(2 4)`, where E2 survives.
   - The prize: a bowtie fragment on a disc of radius `≥ √3` about `p` refutes K1 locally at that radius.
2. **A Reuleaux bowtie with a lune ring carrying arcs of `ω(p)`** (the proof side's remaining bowtie case): build one by formula, or name its stop.
3. **The pinwheel and the `(2, 1, 1, 0)` patterns**, if context remains: a fragment by formula holding a degree-4 vertex with three or four tactic edges in
   a non-bowtie arrangement, or the obstruction.

State each object's class: fragment or map, Siamese or not, and the radius it holds about `p`.

## Rules

As FS114-Y's brief, with the paths above. **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is
Kooshi's budget decision, and the owner can only review work it knows about. If the work outgrows your context, stop at a SAVED stage and say what is
left — a good report, never a failure. Your hand-back, and your final turn's text, is exactly: "FS114-Y4 idle; no content in this hand-back; my reports
go to the owner by SendMessage".

Thank you.
