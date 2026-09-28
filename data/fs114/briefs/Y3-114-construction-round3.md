*Brief for job **FS114-Y3**, the construction side of FS-114 (the unit-arc question), round 3. Opus 5.5. Written by the product owner, 2026-09-28.
**Sized for about 350k tokens by the harness's count, as guidance** (standing rule 10).*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **Your brief is FS114-Y's, `data/fs114/briefs/Y114-construction.md`, plus
the cards `data/fs114/briefs/ROUND2-card.md` and `data/fs114/briefs/ROUND3-card.md`, plus this file; where they differ, this file wins, then the round-3
card.** Read `data/fs114/briefs/STANDING-RULES.md` in full, rule 0 first.

## What changes

- **Read first:** both cards; then `plans/FS114-Y2-construction.md` in full (stages 1a–1c: your predecessor's bowtie, GAPS, and its list of what is
  left), with `tools/fs114_y2_k1.py` and `data/fs114/fs114-y2/`; then `plans/FS114-YB-verification.md` and its checker `tools/fs114_yb_exact.py`; FS-112's
  FS112-SIX and FS112-A4SIX (statements and grades in `plans/FS112-derivation.md`).
- **Your record** is `plans/FS114-Y3-construction.md` (the usual headings; SAVED stages). Working files go in `data/fs114/fs114-y3/`, tools in
  `tools/fs114_y3_*.py`, the report in `data/fs114/reports/FS114-Y3.md`. Commit subjects are "FS114-Y3: stage n".
- **Fences:** FS114-Y's, plus every proof-side record, working directory and tool (`plans/FS114-N*-proof.md`, `data/fs114/fs114-n*/`,
  `tools/fs114_n*`), their verifiers' (`plans/FS114-NB-verification.md`, `data/fs114/fs114-nb/`), and FS-111's files. The round-3 card gives the proof
  side's results. `plans/FS114-CV-verification.md` and `plans/FS114-CVB-verification.md` are open to you.

## Your side, round 3: the bowtie to radius 2, or its stop

Each stage is SAVED and committed; objects by formula, checked exactly by a calibrated checker (YB's, unedited, beside any of yours, which must accept the
five controls first). Every stop is read as a statement about every valid map (G79) and sent to the owner at once.
1. **Extend FS114-Y2-BOWTIE toward radius 2 about `p`**, or derive where it stops, at a named radius and a named step. The test is FS112-SIX at each
   five-colour `q_i` (about 113° more unit arcs about each), then A4SIX at `top` and `bot`. Try the extension member by member, each choice derived, with
   free parameters counted against the configuration's (G21).
2. **Is the five-colour `q_i` forced?** Derive whether every valid map with a Reuleaux bowtie at `p` (two width-1 Reuleaux triangles corner to corner,
   four tactic edges) has five colours at each `q_i`, or build a bowtie whose `q_i` carry four. A four-colour `q_i` escapes SIX's 180° demand.
3. **If context remains:** the other K1 configurations, the pinwheel and the `(2, 1, 1, 0)` three-tactic patterns (Y2's §1c item 2, shaped by GAPS).

State each object's class: fragment or map, Siamese or not, and the radius it holds about `p`.

## Rules

As FS114-Y's brief, with the paths above. **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is
Kooshi's budget decision, and the owner can only review work it knows about. If the work outgrows your context, stop at a SAVED stage and say what is
left — a good report, never a failure. Your hand-back, and your final turn's text, is exactly: "FS114-Y3 idle; no content in this hand-back; my reports
go to the owner by SendMessage".

Thank you.
