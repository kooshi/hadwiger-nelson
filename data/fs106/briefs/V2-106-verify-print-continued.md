*Brief for job **FS106-V2**: finish FS106-V's sighted verification (its §3.3 and stages 5–6). Opus 5.5, 2026-09-26. Written by the product
owner. **Sized for about 250k harness tokens; hand back by 350k.** Not blind.*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **`data/fs106/briefs/STANDING-RULES.md` is part of this brief;
rule 0 first.** You continue FS106-V, which halted at its budget line with stage 3 saved. Its brief is `data/fs106/briefs/V106-verify-print.md`
(read it: your task is its remainder) and its record is `plans/FS106-V-verification.md` (read it in full: you extend it in a new section
"§ Continuation — FS106-V2", never rewriting its verdicts).

## What is left (FS106-V's own list)

1. **`[SokolovVoronov2025]` §7 and the verdicts not yet given:**
   - SV-L4 (a), with bichromatic vertices of degree ≥ 4;
   - SV-L3's transversality step and a repair for `√3 ≤ |u1−u2| < 2`, where the printed proof fails because Fig. 5's triangle is bipartite
     there — FS106-V sketched one;
   - Observation 1 and Prop. 8;
   - then SV-1 and SV-2 whole.

   A blind verifier (FS106-VB) has finished these claims. Its record is open to you **only after you commit your own verdicts on SV-L3,
   SV-L4, Obs. 1, Prop. 8, SV-1 and SV-2**. Then compare, and record every divergence.
2. **Stage 5's readings:**
   - TW-81, `[Townsend1981]` (held: `~/source/library/papers/townsend-1981-*.pdf`);
   - `[Thomassen1999]` (held as text: `~/source/library/papers/Thomassen-1999-On-the-Nelson-unit-distance-coloring-problem.txt`);
   - Parts 2020c (arXiv:2010.12668; fetch it);
   - whatever else V106's brief lists.
3. **Stage 6** as V106's brief defines it. Include the quote-check of FS-103's I-D1, I-D2, I-D4 and I-CE against
   `plans/FS103-M-derivation.md` (FS106-VB could not reach it).

**Aim at repair, not only verdict** (rule 0): where a printed step is a GAP, try to close it and say at what grade. A repaired
Sokolov–Voronov is a regular-class seven this project can stand on.

## Rules

- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and
  the owner can only review work it knows about.
- **Touch only** `plans/FS106-V-verification.md` (the new section only), `data/fs106/fs106-v/` and `tools/fs106_v_*.py`.
- Commits by explicit path, subjects "FS106-V2: stage n"; push; never amend or force-push.
- Report (standing rule 9) to `data/fs106/reports/FS106-V2.md` and by SendMessage to "main". Final turn text: "FS106-V2 idle; report sent to
  the owner by SendMessage".

Thank you.
