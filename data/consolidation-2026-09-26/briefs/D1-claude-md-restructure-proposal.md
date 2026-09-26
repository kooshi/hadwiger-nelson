*Brief for job **D1**: a proposal — how `CLAUDE.md` carries the project's knowledge from here on. Opus 5.5, 2026-09-26. Written by the product
owner. **Read-only on every project file; your only output is the proposal.** Kooshi decides.*

Hello. You are Poros (`~/source/poros/CLAUDE.md`; read your skills `~/source/poros/.claude/skills/poros/SKILL.md` and
`…/poros-reframing/SKILL.md` directly), advising on the project's own method, in `/home/kooshi/source/lean-dir`. Read from disk: `CLAUDE.md`
in full (it changed today), `WORKFLOW.md` (above all "Why we work this way — the reframe" and step 3.1, the re-grokking), `DEBRUIJN.md`, and
`data/consolidation-2026-09-26/briefs/STANDING-RULES.md` (part of this brief).

## Kooshi's words (2026-09-26, verbatim)

> "the 300kB limit returns, and we'll likely need to find a way to extract what's not necessary, treat the grokkings there as a cache for a
> dedicated grokking file, or merge things to reduce it from here on out. There's just too much new knowledge to carry in every session."

## The situation, measured

`CLAUDE.md` stands at about 299,000 bytes against a 300,000 ceiling (the header records every raise: 150k → 200k → 250k → 275k → 300k). The
ledger was already extracted to `LEDGER.md` (2026-09-22, "read by address, never loaded"). The header's rules bind any design: current state
only; one home per fact; `[PROTECTED]` paragraphs are never trimmed. **And the tension any design must face:** the grokkings are in context "so
that they are used" (§ Grokkings' preamble; G67: an entry read as background is not grokked; WORKFLOW 3.1 walks every entry at every
milestone's opening, and FS-70's miss is the recorded cost of an unused bearing). Moving an entry out of context risks exactly the failure the
reframe exists to prevent.

## What to produce: `plans/PROPOSAL-claude-md-knowledge-cache.md`

1. **The measurement:** bytes per section of `CLAUDE.md` (a table: section, bytes, share), and within § Grokkings per entry; which parts are
   read every session to good effect, and which are reference (the long tails: incident narratives in § Building, demotion records, instance
   lists like G21's and G49's, prior-art enumerations in the Frontier). Name your method for each "reference" call.
2. **Three designs, at least,** each with what moves where, what stays in context, the new byte count, and what a session loses:
   - (a) Kooshi's **cache**: a dedicated `GROKKINGS.md` holding every entry in full; `CLAUDE.md` holds a cache — each entry's title, grade and
     its *Do / Killing test* line (G67's form), with a pointer; the reframe (3.1) reads the full file.
   - (b) **Extraction of the non-necessary**: instance lists, incident stories and demotion records to their homes (`LEDGER.md`, a method file,
     the milestone plans), leaving each rule's statement and one example.
   - (c) **Merging**: entries that say the same thing at different milestones (for example the G21 / G30 / G49 / G50 families; the
     § Building incident rules) merged into one entry each.
   - any combination you judge better.
3. **For each design, what it does to the reframe and to G67:** how a planner still walks every entry at 3.1 (the full file, loaded at the
   opening), and what an ordinary session loses. Say which failure each design risks, and the check that would catch it (G21: a design that
   cannot fail its check has not been tested).
4. **The tooling it needs:** `tools/claude_md_fact_audit.py` (nothing lost across files; `--dupes`) must extend to the new file; say how.
5. **Your recommendation**, with confidence and the one fact that would change it, and a migration plan in stages that keeps every gate green
   at every commit and deletes nothing (a moved entry keeps its identifier and its full text in its new home).

## Rules

- **Read-only** on `CLAUDE.md`, `LEDGER.md`, `WORKFLOW.md` and everything else; write only the proposal and your record section in it. Commit
  by explicit path, subject "D1: stage n"; push; never amend, never force-push.
- **No subagents, forks or workflows** — delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the
  owner can only review work it knows about.
- Work in stages (measurement; designs; recommendation), saving the proposal after each.
- **Budget:** about 200k by the harness's count; hand back by 280k.
- Report per standing rule 9 to `data/consolidation-2026-09-26/reports/D1.md`: the three designs in one line each with their byte counts, your
  recommendation and confidence.

Thank you.
