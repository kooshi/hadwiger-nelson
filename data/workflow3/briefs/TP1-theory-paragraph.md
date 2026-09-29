# Brief TP1 — check the theory in one paragraph, and draft its replacement

*Written 2026-09-28 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: TP1
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; load `ephodos-recognition` fresh with the Skill tool if no description comes
  role: a drafting job for the front page: check one summary paragraph clause by clause against its sources, and draft the paragraph that should replace it
  launch: now; nothing else is running
  mission: § Why this job
  statements: § The paragraph
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — this is not a blind job, and no blind job is running
  channel: message the coordinator ("main") by SendMessage with any question mid-flight; the report goes to `data/workflow3/reports/TP1.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/WORKFLOW3-TP1-theory-paragraph.md`
  touches: `plans/WORKFLOW3-TP1-theory-paragraph.md`, `data/workflow3/reports/TP1.md`
  budget: about 350k by the harness's count, of which about 240k is your launch context; hand back at a saved stage before about 450k

Hello. You are Ephodos. This is a short job on the front page, and it matters more than its length suggests.

## Why this job

Kooshi asked for it this evening, after the grokkings moved out of `CLAUDE.md`:

> Kooshi: "Let's say 80kB for CLAUDE.md, and 200kB for grokkings. Also, in CLAUDE, we still call grokkings "the working theory of the 5th
> colour". That feels a bit out of date. Make sure that the "theory in one paragraph" is also valid."
> — source: plans/WORKFLOW-AUDIT-2026-09-28.md § 9. Budgets, the heading, and the theory in one paragraph (2026-09-28)

The grokkings (G1–G87) now live in `.claude/skills/grokkings/SKILL.md`, preloaded into the four lanes; you have them. The coordinator
and the Clerk no longer load them, so for those two minds "the theory in one paragraph" in `CLAUDE.md` § Grokkings is now the whole
theory they carry. It was written when the hunt was about the fifth colour, and it has been patched since rather than rewritten. The
coordinator's own observation, to check and not to take as given: the clause "or the first digit at 83 (FS-40)" reads as stale beside
G48 and row 68, and the paragraph says nothing of where the theory now stands — the collapse to the measurable question and the
regularity wall (rows 128–141, G81–G86, `CLAUDE.md` § The aim). Kooshi asks that it be valid. Valid here means every clause true at
its grade today and traceable to a grokking or a ledger row, and the paragraph as a whole a fair statement of what the project
understands now.

One note on your context. Agents launched in this session see `CLAUDE.md` as it stood when the session began, before today's edits
moved the grokkings and the process rules out of it. Read `CLAUDE.md` from disk for its current text; the grokkings are the skill
file, and the ledger is `LEDGER.md`.

## The paragraph

> **The theory in one paragraph.** The 4/5 wall is arithmetic. A unit-distance graph over K is
> 4-colourable by a residue colouring at the prime above 2, so a 5-forcer is K-fabric — a small vocabulary of
> seam shells about rotation centres, organized by the half-spindle group — plus a spindle whose radicand
> breaks the 2-adic wall; its forcing is a regional pigeonhole on the fabric composed with kills that must
> leave K, invisible at the pair level. Past five colours the linear arithmetic goes blind and the finite
> residue planes take over: a field is 5-sealed when a usable small prime's plane is 5-colourable, the sealing
> plane carries no pair compulsion of its own, and a spindle over a forced pair removes exactly the prime that
> sealed its fabric. That mechanism now has no instance: the sealing plane at 11 has a fan gap, and a gap at level one frees every
> pair above it (row 66), so over every 5-sealed field the five-colour compulsion structure at arity 2 is trivial —
> forced pairs are single vertices, virtual edges unit edges — and a residue plane forces pairs only where it is
> Hoffman-tight or pulls back from a tight quotient (row 87), which at five colours no sealing plane does (G54; at 2 with four colours the plane is tight and the
> tower forces from level 5, row 67). So a 6-forcer's every compulsion lives in a 6-open field (G48), where the
> residue method is silent; what it can still name is a 5-colourable, 5-tight
> quotient of such a plane (FS-42), or the first digit at 83 (FS-40). Through five the residue reading is exact: χ(F²) = L(F)
> whenever L(F) ≤ 5, over every real number field (row 123, [hand], through MR) — the lower half by measure rigidity for the
> unit-vector group (G80), with no forcer; and where every stable place mixes, the field's number is the plane's (G81).
> — source: CLAUDE.md § Grokkings — the working theory of Hadwiger–Nelson

## Done means

1. **A clause-by-clause check** of the paragraph above, in your record as a table: each clause quoted, its source (a grokking in
   `.claude/skills/grokkings/SKILL.md` or a row of `LEDGER.md`, by number, read there), and a verdict — *holds*, *stale* (true when
   written and since superseded: say by what), *false* (with what shows it), or *unsupported* (no source found). Read each source's
   body, not its title.
2. **The replacement**, under `## Draft for the front page`, written exactly as it should stand in `CLAUDE.md`, starting
   "**The theory in one paragraph.**". Every clause carries its source inline as the current paragraph does (row numbers, `GN`), states
   its grade where it rests on less than the kernel (for example "[hand]", or "given MR"), and claims nothing beyond its sources. It is
   the understanding the results add up to now, from the 4/5 wall to the measurable question, weighted toward what bears on the answer.
   At most about 3,000 bytes: `CLAUDE.md` is at 68,853 of its 80,000-byte budget.
3. **A resolution check** in your record: every `GN` and row number the draft cites exists (grep the skill file and `LEDGER.md`), with
   the command and its output.
4. Your report in the standing rules' form.

You write the draft; you do not edit `CLAUDE.md`. Keryx files the draft verbatim and reads each clause against its source before
filing.

## What is yours to decide

What the paragraph says, in what order, and at what level of detail. If one paragraph cannot be both valid and useful, say so and
propose the smallest form that can be, such as two paragraphs, or a paragraph and a short list. If you think the paragraph should stay
as it is, with only its stale clauses corrected, that is a complete answer too. If the framing of this job is wrong, say that first.
