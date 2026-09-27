*Brief for job **FS110-YB**, the blind verifier of FS110-Y, FS-110 (the tangency seam). Opus 5.5, 2026-09-27. Written by the milestone planner FS110-P;
the owner launches it into FS110-Y's slot at its hand-back, and pastes the statements to verify at launch.*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **`data/fs110/briefs/STANDING-RULES.md` is part of this brief; read it in
full, rule 0 first.**

## What you verify

The owner's launch message holds **FS110-Y's results**: each statement verbatim from its record's "Theorems this phase proved", with its claimed
verdict and grade. The claims they answer are in `data/fs110/claims.md`.
1. **Stage 1:** check that every statement matches the claim list's definitions (the types `P_ess` or `P_cl`, covering pairs, `𝓜_K`). Then
   restate each in your own words and register your expected verdicts, with both outcomes reachable.
2. **Stage 2:** derive every verdict yourself from the statements alone, before you open FS110-Y's record: TRUE with your derivation, FALSE with a
   counterexample, GAP at a named step, or MISSTATED with the corrected statement, graded. Run the killing tests of the list's §4 that apply.
   - **Your extra duty (the construction side):** rebuild every candidate from its formula alone and check it with **your own** exact checker, built before you look at the side's checker. It gets planted faults, a known-REJECT control, and the tight hexagonal seven-colouring as an ACCEPT control. ACCEPT is the suspect verdict of a derived-distance checker: a lost tile pair turns a REJECT into an ACCEPT. For each same-colour tile pair, including a tile with itself, check that 1 is not interior to the exact cross-distance range. Also check class densities (at most 0.2470) and the Siamese-or-`≥ 1` rule.
3. **Stage 3:** commit your verdicts. Only then open `plans/FS110-Y-construction.md`, `data/fs110/fs110-y/` and `tools/fs110_y_*`.
4. **Stage 4:** list every divergence — of truth, of scope, of route — item by item, and propose edits for the close. You edit nothing outside your
   own files.

Audit a TRUE at the rate of a FALSE (G21). Every divergence of truth at FS-106 and FS-107 came from a blind verifier. A theorem line that drops its
lemma's hypotheses is a MISSTATED (FS-107's M3).

## Reading

`CLAUDE.md` § The aim, § Counter-priors, G82, G21, G71, G79; `LEDGER.md` rows 131–133; `data/fs110/claims.md` in full; `plans/FS107-derivation.md`;
the sources the claims quote (`plans/FS106-TS-derivation.md` §2.2 and l. 258, 273–275; `plans/FS107-V-verification.md` §4.3;
`plans/FS107-VW-verification.md` §2b.4, §4; `plans/FS106-V-verification.md` l. 368–374); the held papers in `~/source/library/` (Sokolov–Voronov,
Townsend's 1979 manuscript, Woodall 1973 §3, Voronov 2023).

**Fences** (standing rule 13; protocol §1 rule 1). Do not open, list or grep:
- the transcripts under `~/.claude/projects/-home-kooshi-source-lean-dir/` (memory and subagents included); `chats-bak/`; every shared-scratchpad file
  you did not create — work in `scratchpad/fs110-yb/`;
- **`plans/FS110-tangency-seam.md`** (the plan: its §G and §IQ carry routes); both advisors' records
  (`plans/POROS-2026-09-27-fs110-tangency-seam.md`, `plans/POROS-2026-09-27-fs110-competition.md`, `data/fs110/fs110-a/`, `data/fs110/fs110-a2/`);
- **FS110-Y's record, directory and tools until your stage 3 is committed**; the other side's record `plans/FS110-N-proof.md` and `data/fs110/fs110-n/`; the other verifier's
  `plans/FS110-NB-verification.md` and `data/fs110/fs110-nb/`;
- `plans/FS110-close-inventory.md`, `data/fs110/reports/`, every brief in `data/fs110/briefs/` other than yours and `STANDING-RULES.md`;
- `git log` beyond the start-up snapshot, and `git log -p` on any path, until you hand back.
Exclude every fenced path from every grep. A touch by accident is logged and disclosed in your report.

## Rules

- **Touch only** `plans/FS110-YB-verification.md` (heading "Theorems this phase proved"; SAVED stages), `data/fs110/fs110-yb/` and `tools/fs110_yb_*.py`. Commit by explicit path,
  subjects "FS110-YB: stage n"; push; never amend or force-push.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner
  can only review work it knows about.
- **The ban** (standing rule 3): exact checks of seconds on objects given by formula only; no search. Keep the "would have searched here" log.
- **Contact:** only `"main"`. Never contact a competitor or an advisor.
- **Budget:** about 300k tokens by the harness's count. Your own count runs at 55–70 % of it, so hand back when your own count reaches about 195k.
- **Report** per standing rule 9 to `data/fs110/reports/FS110-YB.md` and to `"main"` by SendMessage. Your final turn's text: "FS110-YB idle; no content in
  this hand-back; my reports go to the owner by SendMessage".

Thank you.
