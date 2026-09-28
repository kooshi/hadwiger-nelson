*Brief for job **FS114-Y6**, the construction side of FS-114 (the unit-arc question), round 6. Opus 5.5. Written by the product owner, 2026-09-28.
**Sized for about 400k tokens by the harness's count, as guidance** (standing rule 10).*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **Your brief is FS114-Y's, `data/fs114/briefs/Y114-construction.md`, plus
the cards `ROUND2-card.md`, `ROUND3-card.md`, `ROUND4-card.md` in `data/fs114/briefs/`, plus this file; where they differ, this file wins.** Read
`data/fs114/briefs/STANDING-RULES.md` in full, rule 0 first.

## Where K1 stands (after round 5)

K1: a degree-4 vertex of a non-Siamese valid map has at most two tactic edges.
- **The Reuleaux bowtie family is excluded at `√3`**: two routes blind to each other, the construction side's verified (Y4 and YB3, two minds).
- **The pinwheel is excluded at `1 + ε`, outside two named exceptions**:
  - your predecessor's FS114-Y5-PINALL (one mind; its blind check FS114-YB4 is running);
  - separately, the proof side excludes the pinwheel whose ring carries no (Q) arc (one mind; its check is running).
- **Open in the four-tactic case:**
  - the pinwheel's **E1** (an edge at `p` of exactly 60°, forcing a 60° cone and an empty pocket) and **E2** (a blade whose counter-clockwise side is a unit arc
    centred at its clockwise edge end);
  - **non-Reuleaux lenses**;
  - the **non-simple bowtie**.
- **Open in general:** the **`(2, 1, 1, 0)` patterns**, and three tactic edges in general.

## What changes

- **Read first:** the cards; `plans/FS114-Y5-construction.md` in full (RAINBOW, REGION, MU, ALT, POCKET, CASE, REDUCE, PX, PXKILL: your machinery) with
  `tools/fs114_y5_*`; `plans/FS114-Y4-construction.md` and `plans/FS114-YB3-verification.md` (SIDES, UPDOWN, W, LUNE); `plans/FS114-YB2-verification.md` (YB2-DE,
  the straddle computation); `plans/FS114-L60-audit.md` (FS112-L60 is "at most 60°", with the equality shape — E1 is its boundary case: read it closely).
- **Your record** is `plans/FS114-Y6-construction.md` (the usual headings; SAVED stages). Working files go in `data/fs114/fs114-y6/`, tools in
  `tools/fs114_y6_*.py`, the report in `data/fs114/reports/FS114-Y6.md`. Subjects are "FS114-Y6: stage n", neutral.
- **Fences:** FS114-Y's, plus every proof-side record, directory and tool (`plans/FS114-N*-proof.md`, `data/fs114/fs114-n*/`, `tools/fs114_n*`) and the proof
  verifiers' (`plans/FS114-NB*`, `data/fs114/fs114-nb*/`); the running construction verifier's (`plans/FS114-YB4-verification.md`, `data/fs114/fs114-yb4/`);
  FS-111's files.

## Your side, round 6

Objects by formula, checked exactly by a calibrated checker (YB2's or YB3's, unedited, beside yours, which must accept the five controls first). Every stop
is read as a statement about every valid map (G79) and sent to the owner at once. Each stage is SAVED and committed.
1. **The pinwheel's E1 and E2.** Build a pinwheel fragment through E1 or E2, holding the closed unit disc about `p` and as much beyond as it goes. Or derive
   that each is impossible with the same machinery. E1 is FS112-L60's equality case, a Reuleaux cap: build from the audit's equality fragment.
2. **The `(2, 1, 1, 0)` patterns**, and three tactic edges in general: a fragment by formula holding a degree-4 vertex with three tactic edges, pushed as far
   as it goes, or the obstruction at a named radius. **If three tactic edges survive to radius 2 while four do not, say so plainly**: K1 would then fail,
   and route T's kill becomes the joint payment.
3. **If context remains:** non-Reuleaux lenses at four tactic edges.

State each object's class: fragment or map, Siamese or not, simple or not, and the radius it holds about `p`.

## Rules

As FS114-Y's brief, with the paths above. **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is
Kooshi's budget decision, and the owner can only review work it knows about. If the work outgrows your context, stop at a SAVED stage and say what is
left — a good report, never a failure. Your hand-back, and your final turn's text, is exactly: "FS114-Y6 idle; no content in this hand-back; my reports
go to the owner by SendMessage".

Thank you.
