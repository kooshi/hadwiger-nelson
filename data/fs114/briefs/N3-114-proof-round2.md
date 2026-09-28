*Brief for job **FS114-N3**, the proof side of FS-114 (the unit-arc question), round 2. Opus 5.5. Written by the product owner, 2026-09-28.
**Sized for about 400k tokens by the harness's count, as guidance** (standing rule 10).*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **Your brief is FS114-N's, `data/fs114/briefs/N114-proof.md`, plus the
round-2 card `data/fs114/briefs/ROUND2-card.md`, plus this file; where they differ, this file wins, then the card.** Read
`data/fs114/briefs/STANDING-RULES.md` in full, rule 0 first.

## What changes from FS114-N's brief

- **Read first:** the card, then `plans/FS114-N-proof.md` in full (stage 1 and § Continuation — FS114-N2), then `plans/FS114-NB-verification.md`
  (the blind verifier of your side; it is open to you). Then the plan's §G part 3, §IQ, 5.0–5.4 (§5.3 is open to you) and `data/fs114/claims.md`.
- **Your record** is a new file, `plans/FS114-N3-proof.md`, with the usual headings ("Theorems this phase proved", the would-have-searched log, the fence
  log) and SAVED stages. Working files go in `data/fs114/fs114-n3/`, tools in `tools/fs114_n3_*.py`, the report in `data/fs114/reports/FS114-N3.md`.
  Commit subjects are "FS114-N3: stage n".
- **Fences** are FS114-N's, and they now also cover the construction side's round-2 files (`plans/FS114-Y2-construction.md`, `data/fs114/fs114-y2/`,
  `tools/fs114_y2_*`). The construction side's round-1 record and its verifier's record stay fenced; the card gives their results. So do FS-111's files,
  apart from `data/fs111/claims.md` §2 and `plans/FS111-V0-verification.md`.

## Your side, round 2: the kills

Each stage is SAVED and committed. Every step states the radius it reads and which vertices of `F ∪ R` it reads (G83).
1. **K1 first** (local, radius 2): a degree-4 vertex of a non-Siamese valid map has at most two tactic edges. Derive it, or derive the configuration that
   escapes. Candidate tools: N2-DIAM's 180° cap per tile, FS112-NB4P's structure at a four-colour vertex, FS112-N3-COR3, FS114-Y-PAIRSHARE and FS114-Y-K6
   (all on the card, at their grades). If K1 is FALSE, say which charge-positive vertex types must pay jointly, and aim the kill there.
2. **K2-loc**: under K1, exclude the zero-charge extreme at a uniform radius, using its derived shape (the card).
3. **GAP-μ**: pockets and holes in the count (N2-MU; holes hold at most five tiles).
4. **SIAM-KILL, if context remains**: the Siamese class, which no count reaches. Start from FS112-N3-DENSE3's `R` half and N2-REFINE, and say what an
   argument there must read.
5. **The THOM-TOP third mind is not yours**: N and NB disagree there, and a blind job will settle it. Do not re-derive it.

State each verdict's scope: Q-full, or its non-Siamese part, and whether any complexity bound is used.

## Rules

As FS114-N's brief, with the paths above. **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is
Kooshi's budget decision, and the owner can only review work it knows about. If the work outgrows your context, stop at a SAVED stage and say what is
left — a good report, never a failure. Your hand-back, and your final turn's text, is exactly: "FS114-N3 idle; no content in this hand-back; my reports
go to the owner by SendMessage".

Thank you.
