# Brief FS129-P1 — the re-rank after FS-129, and the question of the next milestone

*Written 2026-10-03 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS129-P1
  identity: Poros — your agent file (`.claude/agents/poros.md`) is your identity and your lane's workflow (job 1: the re-rank and the next question); invoke `poros-anomaly-hunt` fresh with the Skill tool for the re-read, as job 1 says
  role: the ask lane after FS-129's record — re-read the audit's record, draft the re-rank of the frontier, and pose or re-aim the question of the milestone that follows the Lean backlog
  launch: now, beside FS129-L1 (the Clerk, the Lean backlog's input) and the day's Searcher, which write other files
  mission: § Why this job
  statements: § What Kooshi asked
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in FS-129 is blind (Workflow 3.1)
  channel: message the coordinator ("main") by SendMessage only for a question you cannot work around; the report goes to `data/fs129/reports/FS129-P1.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/POROS-2026-10-03-fs129-rerank.md`
  touches: `plans/POROS-2026-10-03-fs129-rerank.md`, `plans/STUB-*.md` (question sections, and the stubs your re-rank needs to mint — never a banner, never another lane's bearing lines), `data/fs129/p1/`, `data/fs129/reports/FS129-P1.md`
  budget: about 350k by the harness's count, as guidance (your launch preloads the grokkings, about 150k); hand back at a saved stage before about 500k

Hello. You opened this audit with the card that aimed it (`plans/POROS-2026-10-03-fs129-card.md`); its readers and its record job have now
reported, and you close the loop. The audit moved the frontier: the top-ranked stub's first question is answered, a new stub exists, several
open stubs carry new bearing lines, and a route was found with no carrier. Your re-rank decides what the project works on after the Lean
backlog, which Kooshi has put next.

## Why this job

Kooshi's order (the handoff, `plans/SESSION-HANDOFF-2026-10-03.md` § 1, item 4): FS-129; then the Lean backlog, in a session of its own; then
the top of the ranking — yours. The audit's request is quoted under § What Kooshi asked; its last clause, "potentially finding new paths", is
what your re-rank turns into milestones. Workflow 3.1's re-rank is your lane's job 1 (`.claude/agents/poros.md` § Your jobs): re-read the
record on purpose, draft the re-rank, choose the milestone, and pose its question.

## What Kooshi asked

> Right after this close, we'll be refining the workflow again... then I think it might be worth an audit of all previously novel lemmas and theorems in this project, to see where they can be applied across all others, interweaving and strengthening what we have, and potentially finding new paths. File that as a special case stub for after the workflow refinements.
> — source: plans/STUB-cross-application-audit.md § The request

> Also a note for the whole plan that not only are "hubs" important, but deep "roots", where a long chain of theorems starts, even if it has only one offshoot
> — source: plans/FS129-cross-application-audit.md § 1. Kooshi's words

## What you work from

- **The record**: `plans/FS129-derivation.md` (44 entries; 12 superseded, marked), `plans/FS129-Z1-record.md`, `plans/FS129-Z2-record.md` (its
  stubs, its scored predictions — your A1–A7 among them, § Stage 6 — its sweeps, § Stage 7, and its drafts for the front page, § Drafts for the
  front page, including ledger rows 149–154 and item 31 as drafted); the readers' records `plans/FS129-OA1-audit.md` … `plans/FS129-SR3-audit.md`
  as you need them; the inventory `plans/FS129-close-inventory.md` (items 1–146).
- **What changed in the stubs**: FS-130 minted (`plans/STUB-bicycle-windings.md`, unranked); FS-123 re-aimed — its question 1 answered yes in the
  non-Siamese class, simple or not, its question now the Siamese half (FS-123's banner, drafted in `plans/FS129-Z2-record.md` § Stage 4, filed by
  Keryx); bearing lines and dated notes in FS-104, -115, -117, -120, -122, -123, -124, -125, -126 (Z2 § Stage 4).
- **Items addressed to you** (inventory item 146, from Z2; and items 26, 43, 58, 138): rank FS-130; choose a carrier for the map step at five
  (drafted as ledger row 154); `plans/FRONTIER-STUBS.md` rank 5's "meet nowhere below the answer", which holds under Condition 5 only (item 58);
  your FS-128 card's "covered by the five lower colours", exact only where max P(x) is the sixth colour (item 43); the demand list's J10, half
  true (item 138); and Z2's partial counterexample to the §IQ rule — the audit's results came from the card's existence form step by step, and
  neither pass-1 reader tallied the steps that need a new kind of input, so your card's hunch went unscored.
- **Your hunch ledger**, carried forward from `plans/POROS-2026-10-03-fs129-card.md` § 1.4, scored in the open.

## Done means

1. **The re-read**, with `poros-anomaly-hunt` and expectations written first: what is curious in the audit's record, which result stands without
   its mechanism, which path nobody has considered. The audit's own pattern is data — one law found three times, one lemma proved three times,
   a theorem's reach set by its argument rather than its statement (Z2's proposed G92) — say what it predicts about where the next miss is.
2. **`## Draft re-rank`** in your record, written exactly as `plans/FRONTIER-STUBS.md`'s rows should read: each row with its bearing on the answer,
   stated honestly; FS-130 and every candidate the audit surfaced at its rank; a banner line for each stub you demote, saying why; and the top
   three as `CLAUDE.md` § Paths forward should carry them. Rank by bearing on the answer, never by difficulty (`CLAUDE.md` § Counter-priors, rule
   1). Keryx files it verbatim.
3. **The next milestone** (after the Lean backlog): the top of your ranking unless you say why not, with its question posed in its stub as your
   lane's job 1 sets out — `## The question (Poros, <date>)` with `### The card`, `### Existence form`, `### Structural form` — or re-aimed in
   place if the stub's question changed (FS-123's did).
4. **The corrections addressed to you**: your FS-128 card's wording, in the stub that holds it, as a dated correction under it; J10's, in your
   record (the demand list is closed).
5. Your record gated with `python3 .claude/skills/poros/scripts/poros_gate.py all <record>` before each stage's commit, with the `Invention
   signal:` line and the heading "Theorems this phase proved" (none); and the report in standing rule 11's form.

## What is yours to decide

The ranking, the next milestone, the carrier for the map step at five, and whether any audit candidate deserves a stub of its own. If the
audit's results change your view of the order Kooshi set — the Lean backlog before the next milestone — say so with the reason; that is a
frame question for him, through the coordinator.
