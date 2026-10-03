# Session handoff — 2026-10-03: Workflow 3.1 adopted; next, a fresh session for FS-129

*Rewritten 2026-10-03 21:00 UTC by Keryx after the workflow refinement. Current state only; the day's history is in git, in the two close
inventories and in `plans/WORKFLOW3-lane-edits-proposed.md`. A successor arriving with nothing reads this first.*

## 1. Read first

1. You are Keryx if your system prompt carries `# Keryx in lean-dir — the workflow` and says **Workflow 3.1**. If it does not, this session's
   output style predates the refinement: restart the session before launching anything (the output style loads only at session start).
2. **Start FS-129 in a fresh session.** Agents receive the parent session's loaded `CLAUDE.md`, not the file on disk, and this session
   loaded the Workflow 3.0 text; a fresh session loads 3.1's.
3. **No milestone is open and no agent is running.** FS-116 and FS-121 are closed undecided (rows 142–148); their inventories are ticked in
   full; the front page, `plans/FRONTIER-STUBS.md` and the Proof Atlas (artifact https://claude.ai/artifact/7zzeXoXvTLHzqf4mTQujzx) are current.
4. **Kooshi's order** (2026-10-03):
   1. **FS-129, the cross-application audit** (`plans/STUB-cross-application-audit.md`), a special case outside the ranking; its method and
      staffing are its opening's to propose and Kooshi's to approve.
   2. **The Lean backlog**, in a session of its own: the hand results of the milestones closed before Workflow 3.1 (about 75 derivation
      entries name de Bruijn: FS-111 16, FS-114 3, FS-116 41, FS-121 15; earlier milestones' hand results besides).
   3. Then Poros's ranking, whose top is FS-123, the (Q)-free ring.
5. **At most three agents at a time** (Kooshi, 2026-10-03), the Searcher included.

## 2. Workflow 3.1, in one paragraph

Kooshi's ruling and decisions, verbatim: `plans/WORKFLOW3-lane-edits-proposed.md`, its first two sections. No blind verifier and no
boundary re-read in the standard loop: the kernel is the second check, and a milestone moves Not started → Opened → Derived (Ephodos's
record job filed) → Closed (its Lean module passes the gate). Poros ranks and chooses the next milestone. de Bruijn is split: a planner
(Opus; blind on the claim list first, then reads the derivation; reports generalizations and statement defects at once, which Keryx
relays to the frontier job) and an implementer (Sonnet; never changes a statement). Milestones may assume the literature in Lean
(formalize anything under about an hour of agent work; imports carry four items, `LEAN.md` § Assumptions). Search runs once a day, by
the Searcher, from `plans/SEARCH-QUEUE.md`; no other lane searches. No one-line `LEDGER.md` § B entries from 3.1 on. The text cut from the
loaded files is `plans/HISTORY-WORKFLOW-3.0.md`; the arithmetic-era items of "Where the problem stands" are
`plans/WHERE-THE-PROBLEM-STANDS.md`.

## 3. Open items

- **The brief gate's defects** are filed in `~/source/agent-forge` (commit 95816ff, not pushed): `forge/STATUS.md` under Keryx, with
  `identities/keryx/record/evidence/defects-2026-10-03/repro.sh` (four false failures, U3a, U3b, U5, U6; two false passes, U7, U4). Until they
  are fixed and re-imported, a brief failing on one notes it and launches.
- **The Searcher's identity** is a stub in agent-forge (`identities/_unnamed-searcher/README.md`), at Kooshi's word: probably not needed;
  fleshed out only if the lane shows it needs more craft.
- **The census** `tools/fs71_ledger_b_check.py --strict` checks derivation files against `LEDGER.md` § B, which stops at FS-116 and FS-121; it
  is no longer run at a filing, and a 3.1 derivation file will fail it by design.
