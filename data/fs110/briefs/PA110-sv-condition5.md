*Brief for job **FS110-PA**: a narrow prior-art check for FS-110's possible third round. Opus 5.5, 2026-09-27. Written by the product owner.
**Sized for about 150k tokens by the harness's count.** Your own count runs at 55–70 % of it, so hand back when your own count reaches about 100k.*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **`data/fs110/briefs/STANDING-RULES.md` is part of this brief; read rule 0
and rules 5, 11 and 13.**

## The question

The competition advisor (FS110-A4) recommends a third round on the unit circle of a four-colour seam point. In that round the proof side would work
Q-rule under `[SokolovVoronov2025]`'s Condition 5 (no unit arcs on boundaries), **without** their Condition 6. The advisor asks for a prior-art check
first. Answer it exactly:

1. **What do Sokolov–Voronov prove, state or ask about maps with Condition 5 but not Condition 6?** Read their §9 (the open questions) and every
   place Conditions 5 and 6 are used or discussed, quoting each verbatim with its page.
   - Their paper is held at `~/source/library/pdf/arXiv-2502.01958-maptype.pdf`.
   - FS-106 verified their proofs: `plans/FS106-V-verification.md` (§ Continuation — FS106-V2 covers Condition 6's steps) and
     `plans/FS106-derivation.md`. Read those for what is already known, and do not redo them.
2. **Has anyone since proved or refuted a Condition-5-only statement?** Search the citing works of `[SokolovVoronov2025]` (arXiv:2502.01958), and of
   `[Voronov2023]` (arXiv:2304.10163) for anything on maps. Use OpenAlex and Semantic Scholar, compare their identifiers (G49), and add the zbMATH
   API (WORKFLOW 3.2 item 8). Also search, in the literature's own words, for "map-type colouring", "unit distance" with "tangent", and "Townsend"
   with "Woodall" after 2020.
3. **Townsend's 1979 manuscript and Woodall 1973:** do either of them treat maps with unit-arc boundaries excluded, but with bichromatic vertices of
   degree ≥ 4 allowed? They are held in `~/source/library/` (FS-106's V3 read them; see its section of the same verification file).

## What to produce

A short record, `plans/FS110-PA-prior-art.md`:
- each finding quoted verbatim with its address;
- the searches run, with their queries and counts (a negative is a finding);
- one line on what it means for a Condition-5-only round.

Propose `BIBLIOGRAPHY.md` rows; do not edit that file.

## Rules

- **Touch only** your record and `data/fs110/fs110-pa/`. Commit by explicit path, with subjects "FS110-PA: stage n", and push. Never amend or force-push.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner
  can only review work it knows about.
- **Fences:** standing rule 13's three channels, plus the two blind verifiers' records (`plans/FS110-NB-verification.md`,
  `plans/FS110-YB-verification.md`, `data/fs110/fs110-nb/`, `data/fs110/fs110-yb/`). Never contact any agent but `"main"`.
- Report to `data/fs110/reports/FS110-PA.md` and by SendMessage to `"main"`. Your final turn's text: "FS110-PA idle; report sent to the owner by
  SendMessage".

Thank you.
