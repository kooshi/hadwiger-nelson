# Brief R1 — Poros: the boundary re-read of FS-114's and FS-111's closes, and the draft re-rank

*Written 2026-09-28 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: R1
  identity: Poros — your agent file (`.claude/agents/poros.md`) is your identity and your lane's workflow; invoke `poros-anomaly-hunt` fresh with the Skill tool for the re-read, and `poros-reframing` if a frame will not move
  role: the boundary re-read of two closed milestones, and the draft re-rank of the frontier
  launch: after both close jobs, FS114-C and FS111-C, have handed back and the coordinator has reviewed their records
  mission: § Why this job
  statements: none — a re-read and a re-rank; every input is a record named by address in § What you read
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — no blind job is running; both milestones are closed when you start
  channel: message the coordinator ("main") by SendMessage with any question mid-flight; the report goes to `data/workflow3/reports/R1.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/POROS-2026-09-28-close-reread.md`
  touches: `plans/POROS-2026-09-28-close-reread.md`, `data/workflow3/r1/`, `data/workflow3/reports/R1.md`
  budget: about 300k by the harness's count, as guidance; hand back at a saved stage before about 450k

Hello. You are Poros. Two milestones have just closed, the first two closes run under the new pipeline (`CLAUDE.md` § The pipeline),
and the frontier needs its re-rank before a fresh session opens the next one.

## Why this job

Kooshi ruled today to close both milestones and then hand the project to a fresh session:

> "Understood. Let's close up, then hand off to a completely fresh session with a note to check for keryx and be watchful of the new workflow in comparison to the old."
> — source: plans/WORKFLOW3-test-drive.md row K2

The fresh session opens the next milestone from your ranking, so the ranking is the hand-off's most consequential page. Your lane
file's job 3 is this job: re-read each close's whole record on purpose, not its summary, and draft the re-rank from what you find.

## What you read

- **The two close records and what they cite**: `plans/FS114-C-close.md` and `plans/FS111-C-close.md` (each with its reconciliation,
  headline, sweeps and `## Drafts for the front page`), the derivation files and stubs they name, and the close inventories
  `plans/FS114-close-inventory.md` and `plans/FS111-close-inventory.md`. Go under the summaries to the job records they cite wherever
  the anomaly hunt points you.
- **The frontier as it stands**: `plans/FRONTIER-STUBS.md` (authoritative, with its columns) and `CLAUDE.md` § Paths forward, ranked.
- **Your hunch ledger**, carried forward from `plans/POROS-2026-09-27-night-aim.md` § 5, with that record's § 2 ranking and § 3's
  first questions.

## Done means

1. **Your record, `plans/POROS-2026-09-28-close-reread.md`**, passing `python3 .claude/skills/poros/scripts/poros_gate.py all
   plans/POROS-2026-09-28-close-reread.md` from the repository root before each stage's commit, holding:
   - the readback of this brief's quotation;
   - **your expectations, written before the re-read**: what you expect the closes to show, so the re-read can surprise you;
   - **the re-read**, by the anomaly hunt: what is curious in a way that makes you wonder what pattern caused it, what path nobody has
     considered, which result stands without its mechanism;
   - **the hunch ledger, carried forward and scored in the open**, killed hunches kept;
   - **`## Draft re-rank`**: the ranked-stubs table of `plans/FRONTIER-STUBS.md`, written exactly as its rows should read, with every
     column the table has; every candidate the two closes surfaced (their new stubs FS-116 to FS-122, whichever were minted) at its
     rank; FS-114 and FS-111 moved to the closed list; a banner line for each demoted stub, saying why;
   - **`## Draft for CLAUDE.md § Paths forward`**: the ranked table's rows as `CLAUDE.md` should carry them (short cells; the
     authoritative text stays in `plans/FRONTIER-STUBS.md`), and the "Next:" clause of the open-milestones line, naming the milestone
     the fresh session should open. The two closes drafted that line too; where your "Next:" differs from theirs, say so and why. State
     your drafts' net bytes against the current table: `CLAUDE.md` has about 11,000 bytes of room under its 300,000-byte limit for
     both closes and this re-rank together, so aim at 2,000 net bytes or fewer.
2. **The report** in the standing rules' form.

Rank by bearing on the answer, never by difficulty, length or formalization effort (`CLAUDE.md` § Counter-priors, rule 1). The ban on
finite-witness search ends 2026-10-01; the stubs file's solver column says which stubs it gates.

## What is yours to decide

The ranking, the merges and the demotions; whether a close's framing of its own successor is the right question (if it is not, say
so: a question card for the fresh session is welcome in your record, addressed to "a fresh mind"); what the re-read should look at
first. If this brief or a close record is wrong about something, say so: that is a finding, not a refusal.

## Stages (save and commit each; standing rule 2)

1. The readback, your expectations, and the hunch ledger carried forward.
2. The re-read.
3. The draft re-rank and the `CLAUDE.md` draft, then the report.

Thank you.
