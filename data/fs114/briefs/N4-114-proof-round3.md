*Brief for job **FS114-N4**, the proof side of FS-114 (the unit-arc question), round 3. Opus 5.5. Written by the product owner, 2026-09-28.
**Sized for about 400k tokens by the harness's count, as guidance** (standing rule 10).*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **Your brief is FS114-N's, `data/fs114/briefs/N114-proof.md`, plus the
cards `data/fs114/briefs/ROUND2-card.md` and `data/fs114/briefs/ROUND3-card.md`, plus this file; where they differ, this file wins, then the round-3
card.** Read `data/fs114/briefs/STANDING-RULES.md` in full, rule 0 first.

## What changes

- **Read first:** both cards; then `plans/FS114-N3-proof.md` in full (your side's round 2: DR, N3-DR0, N3-DR1/DR2, N3-CONT, N3-JOINT, N3-PAY) and its
  tools; `plans/FS114-N-proof.md` (stage 1 and § Continuation — FS114-N2); `plans/FS114-NB-verification.md`; `plans/FS114-CV-verification.md` and
  `plans/FS114-CVB-verification.md` (CV-EXISTS). FS-112's FS112-SIX, FS112-A4SIX, FS112-NB4P and FS112-N3-COR3 (statements and grades in
  `plans/FS112-derivation.md`, proofs in the FS-112 records).
- **Your record** is `plans/FS114-N4-proof.md` (the usual headings; SAVED stages). Working files go in `data/fs114/fs114-n4/`, tools in
  `tools/fs114_n4_*.py`, the report in `data/fs114/reports/FS114-N4.md`. Commit subjects are "FS114-N4: stage n".
- **Fences:** FS114-N's, plus every construction-side record, working directory and tool (`plans/FS114-Y*-construction.md`, `data/fs114/fs114-y*/`,
  `tools/fs114_y*`), their verifier's (`plans/FS114-YB-verification.md`, `data/fs114/fs114-yb/`), and FS-111's files. The cards give the construction
  side's results; the held BOWTIE fragment's data is fenced with the side, and the round-3 card states it exactly.

## Your side, round 3: K1 at radius 2, and the local NO

Every step states its reading radius and which vertices of `F ∪ R` it reads (G83). Each stage is SAVED and committed.
1. **The Reuleaux bowtie at radius 2.** The construction side holds a valid fragment realising DR to radius `3√3/5`, each `q_i` of five colours in its
   design (round-3 card). Derive whether a valid map can hold the bowtie on the closed disc of radius 2 about `p`:
   - Start from FS112-SIX's 180° demand at a five-colour vertex whose ring is inside the map.
   - Then A4SIX at `top` and `bot`, and FS112-NB4P's structure there.
   - First settle whether the five colours at `q_i` are forced by the bowtie alone.
   A derived exclusion at a radius `R ≤ 2` is a local exclusion about a four-colour vertex: the first piece of C114-LOCAL-F.
2. **K1 at radius 2 in general**: every degree-4 vertex with three or four tactic edges.
   - GAPS gives the local shapes: the bowtie, the pinwheel, and the `(2, 1, 1, 0)` patterns.
   - Exclude each at radius 2, or name the one that survives.
   - If a pattern survives, move to the joint payment. Continue N3-JOINT and N3-PAY: pay the non-DR deficient patterns, and give a surplus per disc.
3. **C114-LOCAL-F framing:** by CV-EXISTS (two minds), a local exclusion about one four-colour vertex, uniform over configurations, is the whole NO. Say at
   each result how far it goes toward LOCAL-F, and what an explicit `R` would need.

## Rules

As FS114-N's brief, with the paths above. **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is
Kooshi's budget decision, and the owner can only review work it knows about. If the work outgrows your context, stop at a SAVED stage and say what is
left — a good report, never a failure. Your hand-back, and your final turn's text, is exactly: "FS114-N4 idle; no content in this hand-back; my reports
go to the owner by SendMessage".

Thank you.
