*Brief for job **FS110-N2**: continue the proof side of FS-110, the tangency seam, from its stage 4. Opus 5.5, 2026-09-27. Written by the
product owner. FS110-N handed back at stage 3 when it reached its budget line.*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **Your brief is FS110-N's brief, `data/fs110/briefs/N110-proof.md`,
plus this file.** Read that brief in full: its reading list, its fences, its contest rules and its "Your side" section all bind you. Where the two
differ, this file wins. `data/fs110/briefs/STANDING-RULES.md` is part of both; read rule 0 first.

## Where you start

Read FS110-N's record `plans/FS110-N-proof.md` in full; its report is `data/fs110/reports/FS110-N.md`. You continue that record in a new section,
"§ Continuation — FS110-N2", and you never rewrite an earlier verdict. If you disagree with one, say so in your section.

N's record at hand-back:
- **The local calculus, stage 1:** A-EXACT, A-CIRC in its closure form, A-SIX and D-TYPE are TRUE.
- **The new lemmas:**
  - N-SEAM, the seam-point lemma;
  - N-E1 and N-E2;
  - N-HORN, which gives C-CUSP-K TRUE;
  - N-X, the vertex seam point with no unit arc: it forces a four-colour vertex, bowties at `u` and `v`, and a cascade of new covering pairs along
    `ω(w₀)`.
- **Other verdicts:** C-TAN-POS TRUE at a non-vertex `w₀` and a GAP at a vertex `w₀`; C-SEAMLIST MISSTATED, with a corrected necessary list.
- **N's registered bet:** C-T2 (ii) is FALSE at every `K`, because the double unit-arc cascade does not close.

## What is left, in this order

1. **C-ACT1, Act One: are seams needed at all?** N calls it "the NO's missing step". Without it, a NO rests on the seam list alone.
2. **The vertex case S2 with unit arcs at `w₀`.** N-X covers a vertex `w₀` with no unit arc; this is the case with them.
3. **C-T2 (ii)**, N's bet: prove that the double unit-arc cascade does not close, or find where it does.
4. **C-BOW-K (ii)**, the global bowtie claim, where the construction side has bet on GAP.

The competition advisor FS110-A2 has sent both sides card 1: four scope questions, on disjointness, the four-colour escape, one-sided blocks and
C-TAN-POS's scope. N took one retraction on it (the strong-escape claim at type size ≥ 4). Answer any part of card 1 that N left open in your first
saved stage, then go on.

## Rules

- **Touch only** `plans/FS110-N-proof.md` (your new section only), `data/fs110/fs110-n/` and `tools/fs110_n_*.py`.
- Commit by explicit path, with subjects "FS110-N2: stage n". Push after each commit; never amend or force-push.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner
  can only review work it knows about.
- **Fences:** N's list, unchanged. That covers the construction side's files, both advisors' records and working directories, the session
  transcripts, `chats-bak/`, scratchpad files you did not create (work in `scratchpad/fs110-n2/`), and `git log` beyond the start-up snapshot until
  you hand back. A fence touch is disclosed at once.
- The competition advisor's id comes from me by SendMessage. Send every report to `"main"` explicitly.
- **Budget:** about 400k tokens by the harness's count. Your own count runs at 55–70 % of it, so hand back with your record saved when your own count
  reaches about 220k.
- Report under standing rule 9 to `data/fs110/reports/FS110-N2.md`, and by SendMessage to `"main"`. Your final turn's text: "FS110-N2 idle; report
  sent to the owner by SendMessage".

Thank you.
