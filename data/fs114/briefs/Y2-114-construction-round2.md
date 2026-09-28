*Brief for job **FS114-Y2**, the construction side of FS-114 (the unit-arc question), round 2. Opus 5.5. Written by the product owner, 2026-09-28.
**Sized for about 400k tokens by the harness's count, as guidance** (standing rule 10).*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **Your brief is FS114-Y's, `data/fs114/briefs/Y114-construction.md`, plus
the round-2 card `data/fs114/briefs/ROUND2-card.md`, plus this file; where they differ, this file wins, then the card.** Read
`data/fs114/briefs/STANDING-RULES.md` in full, rule 0 first.

## What changes from FS114-Y's brief

- **Read first:** the card, then `plans/FS114-Y-construction.md` in full, then `plans/FS114-YB-verification.md` (the blind verifier of your side; it is
  open to you, with its tools and `data/fs114/fs114-yb/`, including the rainbow third-case fragment). Then the plan's §G part 3, §IQ, 5.0–5.4 (§5.3 is
  open to you) and `data/fs114/claims.md`.
- **Your record** is a new file, `plans/FS114-Y2-construction.md`, with the usual headings and SAVED stages. Working files go in `data/fs114/fs114-y2/`,
  tools in `tools/fs114_y2_*.py`, the report in `data/fs114/reports/FS114-Y2.md`. Commit subjects are "FS114-Y2: stage n".
- **Fences** are FS114-Y's, and they now also cover the proof side's round-2 files (`plans/FS114-N3-proof.md`, `data/fs114/fs114-n3/`,
  `tools/fs114_n3_*`). The proof side's round-1 record and its verifier's record stay fenced; the card gives their results. So do FS-111's files, apart
  from `data/fs111/claims.md` §2 and `plans/FS111-V0-verification.md`.
- **Calibration carries over**: your tools must accept the five controls, and YB's checker (`tools/fs114_yb_exact.py`) is a second checker you may run
  unedited beside FS-112's.

## Your side, round 2: the meeting point, from the other end

Each stage is SAVED and committed. Every object is given by formula and checked exactly, and every stop is read as a statement about every valid map (G79)
and sent to the owner as soon as it is derived.
1. **K1's killing test first.** Build a non-Siamese valid fragment, by formula, holding a degree-4 four-colour vertex with three or four tactic edges
   (unit arcs centred at four-colour vertices at distance exactly 1). Otherwise derive the obstruction at a named radius. The strip's midline vertices
   have none (all four edges straight); start from YB's rainbow third-case fragment and FS114-Y-PAIRSHARE's constraint.
2. **K2's extreme as a design target.** Its shape is on the card: closed non-tactic curves through the four-colour vertices, every other edge a unit arc
   centred at a four-colour vertex 1 from both ends, and absent colours on Reuleaux triangles with corners of degree at least 5. Try a torus design of that
   shape by formula, member by member, or name why each member fails, with its free parameters counted (G21).
3. **The Siamese class, if context remains**: the count cannot see it. Give a fragment that uses Siamese pairs to hold a larger disc about a four-colour
   vertex than `φ²/√2`, or the obstruction.

State each object's class: fragment or map, periodic or not, Siamese or not, bounded complexity or not.

## Rules

As FS114-Y's brief, with the paths above. **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is
Kooshi's budget decision, and the owner can only review work it knows about. If the work outgrows your context, stop at a SAVED stage and say what is
left — a good report, never a failure. Your hand-back, and your final turn's text, is exactly: "FS114-Y2 idle; no content in this hand-back; my reports
go to the owner by SendMessage".

Thank you.
