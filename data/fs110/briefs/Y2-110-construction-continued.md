*Brief for job **FS110-Y2**: continue the construction side of FS-110, the tangency seam, from its stage 4. Opus 5.5, 2026-09-27. Written by the
product owner. FS110-Y handed back at stage 3 when it reached its budget line.*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **Your brief is FS110-Y's brief, `data/fs110/briefs/Y110-construction.md`,
plus this file.** Read that brief in full: its reading list, its fences, its contest rules and its "Your side" section all bind you. Where the two
differ, this file wins. `data/fs110/briefs/STANDING-RULES.md` is part of both; read rule 0 first.

## Where you start

Read FS110-Y's record `plans/FS110-Y-construction.md` in full; its report is `data/fs110/reports/FS110-Y.md`. You continue that record in a new
section, "§ Continuation — FS110-Y2", and you never rewrite an earlier verdict. If you disagree with one, say so in your section.

Y's record at hand-back:
- **The local calculus, stage 1:** A-EXACT TRUE, read as "meets the interior of a tile" (the closure reading fails at cusps); A-CIRC TRUE, cusp
  colours included; A-SIX TRUE; D-TYPE TRUE.
- **C-TAN-POS:** TRUE at the level of A-EXACT's disjointness: a pair survives at `w₀` only by an escape, or by T2 at both points. So C-TAN-K and
  C-CUSP-K are TRUE at the pair level.
- **Other verdicts:** C-T2 (i) a GAP at the formula fragment; C-T-BIKE a GAP, with a no-go for one family (Y-BIKE-3C); "strong escape" MISSTATED.
- **The new lemmas:**
  - Y-BLOCK, the shapes of the blocking sets;
  - Y-T2W: T2 at `w₀` forces `w₀` to degree ≥ 4, with the branches of `ω(u)` and `ω(v)` alternating;
  - Y-BIKE-3C.
- **The tool:** `tools/fs110_y_check.py`, an exact curved checker over ℚ(√3), with 7 controls and 4 planted faults.
- **Y's registered bet:** C-BOW-K (ii) is a GAP, because a strong escape is free locally and every global instrument is blind to it.

## What is left, in this order

1. **Y's own next step:** a T2 fragment on the `d = 1` rhombus, with every vertex in ℚ(√3), given by formula and checked by the checker. This is C-T2
   (i) at fragment level.
2. **A bowtie fragment**, the escape Y bets on: a local map with a strong escape at a bowtie, given by formula and checked exactly (C-BOW-K (i)).
3. **The mixed map:** does any map mix the two escapes, T2 seams and bowties? Neither side's registration names one.
4. **C-T-BIKE beyond Y-BIKE-3C's family.** The general tight two-colouring of a circle has not been used.

The competition advisor FS110-A2 has sent both sides card 1. Y took two free retractions on it: "exactly five shapes", and the "fat" row. Answer any
part of card 1 that Y left open in your first saved stage, then go on. **The ban on finite-witness search runs to 2026-10-01**, and Kooshi's ruling
stands beyond it: every candidate is given by formula and checked exactly, and nothing is searched.

## Rules

- **Touch only** `plans/FS110-Y-construction.md` (your new section only), `data/fs110/fs110-y/` and `tools/fs110_y_*.py`.
- Commit by explicit path, with subjects "FS110-Y2: stage n". Push after each commit; never amend or force-push.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner
  can only review work it knows about.
- **Fences:** Y's list, unchanged. That covers the proof side's files, both advisors' records and working directories, the session
  transcripts, `chats-bak/`, scratchpad files you did not create (work in `scratchpad/fs110-y2/`), and `git log` beyond the start-up snapshot until
  you hand back. A fence touch is disclosed at once.
- The competition advisor's id comes from me by SendMessage. Send every report to `"main"` explicitly.
- **Budget:** about 400k tokens by the harness's count. Your own count runs at 55–70 % of it, so hand back with your record saved when your own count
  reaches about 220k.
- Report under standing rule 9 to `data/fs110/reports/FS110-Y2.md`, and by SendMessage to `"main"`. Your final turn's text: "FS110-Y2 idle; report
  sent to the owner by SendMessage".

Thank you.
