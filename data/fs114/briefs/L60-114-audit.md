*Brief for job **FS114-L60**: an audit of FS-112's uses of FS112-L60 at its boundary case, for FS-114 (the unit-arc question). Opus 5.5. Written by the
product owner, 2026-09-28. **Sized for about 250k tokens by the harness's count, as guidance** (standing rule 10).*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **`data/fs114/briefs/STANDING-RULES.md` is part of this brief; read it in
full, rule 0 first**, then `CLAUDE.md` § The aim, § Counter-priors and G21, from disk.

## Why

`plans/FS112-derivation.md` l. 66, verbatim: **"FS112-L60 — A unit arc with constant sides has angular length below 60°; along it neither side colour
recurs 60° apart. [hand; two minds, one blind: N; NB; tools exact]"**, with *"Rests on it: FS112-N2-RED, FS112-N3-COR3."*

FS114-N4 (one mind) found it **false at exactly 60°**, and corrected it to "at most 60°".
- A Reuleaux triangle's cap region is an outer tile along a whole 60° arc.
- Its chord is exactly 1, which equals the allowed diameter.
- The tool that "checked" L60 planted a case just past the boundary (`DIAM_OVER 10201/10000` in `plans/FS112-N-proof.md` l. 376), not at it.

**What rests on this:** FS112-N3-COR3 feeds FS112-N3-BASE, then FS112-N3-DENSE3, then FS114-CV-EXISTS. CV-EXISTS says every valid map has a vertex of at
least four colours, at two minds. It is the step that reduces the whole unit-arc NO to one local exclusion (C114-LOCAL-F). If a strict use of L60 breaks
that chain, the reduction must be repaired before anything more is built on it.

## The job

Each stage is SAVED and committed.
1. **Settle L60 at the boundary.**
   - Decide the exact statement: does "≤ 60°" hold, and is equality realised only by a Reuleaux cap, or by other configurations?
   - Does the second clause ("neither side colour recurs 60° apart") survive at equality?
   - Build the equality case by formula and check it exactly, in a new tool `tools/fs114_l60_*.py`. FS-112's tools are frozen: run them, never edit them.
     Your tool carries a plant **at** the boundary and a plant just past it, each firing for its own reason.
2. **Walk every use of L60 in FS-112 and FS-114.** Grep `L60`, `below 60`, `< 60°` and `60°` in:
   - `plans/FS112-N-proof.md`, `plans/FS112-NB*-verification.md` and `plans/FS112-derivation.md`;
   - FS-114's records `plans/FS114-N*-proof.md`, `plans/FS114-CV*-verification.md` and `plans/FS114-NB-verification.md`, which are open to you.
   For each use, say:
   - does it need the strict inequality, and if so, does the equality case (a Reuleaux cap) break the step, or is it excluded there by another fact?
   - is the step repaired, and with what?
   - **N2-RED and N3-COR3 first, then N3-BASE, N3-DENSE3 and FS114-CV-EXISTS**, then everything else, including `plans/FS112-N-proof.md` l. 284 (N112-P2,
     "four arcs, each < 60°").
3. **Verdict:** is DENSE3, and so CV-EXISTS, intact? If not, name the exact configuration that escapes. It becomes FS-114's first object, and the owner is
   told at once by message, before anything else is written.

## Rules

- **Touch only** `plans/FS114-L60-audit.md` (headings "Theorems this phase proved", the would-have-searched log, the fence log; SAVED stages),
  `data/fs114/fs114-l60/` and `tools/fs114_l60_*.py`. Neutral subjects "FS114-L60: stage n"; push after each commit; never amend or force-push.
- **Fences:** the session transcripts (everything under `~/.claude/projects/-home-kooshi-source-lean-dir/`), `chats-bak/`, every shared scratchpad file you
  did not create (work in `scratchpad/fs114-l60/`), FS-114's construction-side records and FS-111's files, `plans/FS114-close-inventory.md`, and every other
  brief. You may read any FS-112 record and the FS-114 records named above.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner can
  only review work it knows about. If the work outgrows your context, stop at a SAVED stage and say what is left.
- **The ban** (standing rule 3): objects by formula, checked exactly; no search. Keep the would-have-searched log.
- **Contact:** only `"main"`. Report per standing rule 9 to `data/fs114/reports/FS114-L60.md` and to `"main"`. Final text: "FS114-L60 idle; report sent
  to the owner by SendMessage".

Thank you.
