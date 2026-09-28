*Brief for job **VIZ-ATLAS-2**: the Proof Atlas's second version. Opus 5.5, 2026-09-27. Written by the product owner at Kooshi's request. VIZ-ATLAS built
version 1 and is replaced (≈ 512k), not resumed. **Sized for about 250k tokens by the harness's count, as guidance.***

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **Your brief is VIZ-ATLAS's brief, `data/viz/proof-atlas/brief.md`, plus
this file**; where they differ, this file wins. Read `visualizations/proof-atlas/README.md` and `DESIGN.md` first; version 1 is published at
https://claude.ai/artifact/7zzeXoXvTLHzqf4mTQujzx (the owner republishes; you do not publish).

Kooshi, verbatim: *"ooh, very nice artifact. Can you have the agent update it to have a dark mode please? and if we have a new answered question from the
close, have the viz agent fold it in too."* And: *"I'd like to keep this updated as we move forward too."*

## Two stages

1. **Now — the dark mode.** The page already carries dark tokens that follow the viewer's system setting, but Kooshi does not see them: give the page a
   visible theme control (System / Light / Dark) that sets `data-theme` on the root element, remembered per viewer in `localStorage` (try/catch). Review
   the dark palette as a design of its own, not an inversion: contrast of every label, the brick hub, the sector wedges, the hatch, the answer cards and
   the route bars, at both themes. Check the one look (a headless screenshot of each theme). Build, check, commit; report to `"main"`; then wait — the
   owner resumes you for stage 2.
2. **When the owner says FS-112's close has landed — fold it in.** Sources then are `LEDGER.md` rows 135–136 and their § B lines, `plans/FS112-derivation.md`,
   the stubs `plans/STUB-global-step.md` (FS-114) and `plans/STUB-stuck-ray.md` (FS-115), `plans/FRONTIER-STUBS.md`, and `CLAUDE.md` (G83). In particular:
   - **The composition** (FS112-C-COMPOSE): the global step in its dense form is the NO itself, with no ray step; the stuck ray (FS-115) matters only for
     the four-colour form on aperiodic maps. Redraw the route to seven accordingly: version 1 draws the ray as a required link and the composition as a
     missing step. If a missing step is now the whole remaining question rather than a small lemma, say so on its card, and do not let the bits make it
     look smaller than it is.
   - FS-112's round-3 construction claims at their verified grades (FS112-YB3: eight TRUE, Y3-END-NEEDS false as stated, BOWTIE).
   - **Any posed question the close answers** gets its own mark (the close's reading is that none is answered; show what it says). A question closed by a
     no-go or a reduction is shown as such.
   - Re-run the checker first: it names every quote that moved.
3. **Keeping it current** (Kooshi's standing wish): add to `README.md` a short "Updating at a close" section — which files to re-read, the checker, the
   build, and that the owner republishes to the same URL.

## Rules

- As VIZ-ATLAS's brief: touch only `visualizations/proof-atlas/`, `data/viz/proof-atlas/` and `tools/viz_proof_atlas_*.py`; **no subagents, forks or
  workflows** (delegation is one level deep, `CLAUDE.md` § Delegation: staffing is Kooshi's budget decision, and the owner can only review work it knows
  about); contact only `"main"`; commits by explicit path, subjects "VIZ-ATLAS-2: stage n"; push after each; never amend or force-push.
- Your final turn's text at each stage: "VIZ-ATLAS-2 idle; report sent to the owner by SendMessage".

Thank you.
