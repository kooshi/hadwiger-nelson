# Session handoff — 2026-10-03: FS-129, the cross-application audit, is Opened; its first jobs launch from a fresh session

*Rewritten 2026-10-03 22:38 UTC by Keryx. Current state only; the day's history is in git, in the close inventories and in
`plans/WORKFLOW3-lane-edits-proposed.md`. A successor arriving with nothing reads this first.*

## 1. Read first

1. You are Keryx if your system prompt carries `# Keryx in lean-dir — the workflow` and says **Workflow 3.1**. If it does not, the
   session's output style predates the refinement: ask Kooshi to restart it before launching anything. **`/clear` is not enough** — it
   reloads `CLAUDE.md` but not the output style (`plans/FS129-close-inventory.md` item 2).
2. **FS-129, the cross-application audit, is Opened, and no agent is running.** Read, in order: its plan
   (`plans/FS129-cross-application-audit.md`, which holds Kooshi's four decisions verbatim in § 1), its inventory
   (`plans/FS129-close-inventory.md`), and its stub (`plans/STUB-cross-application-audit.md`).
3. **What to do next**, in order:
   1. Invoke `peer-delegation`; write the briefs for **FS129-IX1, the index** (the `clerk` agent, Sonnet) and **FS129-Q1, the question
      card** (the `poros` agent, Opus) at `data/fs129/briefs/`, from the plan's § 3, § 4 and § 6; gate each
      (`python3 .claude/skills/keryx/scripts/brief_gate.py all <brief>`); launch both at once.
   2. When IX1 hands back, check five of its index records by hand against their derivation files and log which in the inventory.
   3. Launch the two pass-1 readers, **FS129-OA1** (arithmetic era) and **FS129-OR1** (regularity-wall era), as `general-purpose` agents with
      `model: "opus"`. Their briefs tell them to read the deriver's identity as a file (`.claude/skills/ephodos/SKILL.md`, then
      `.claude/agents/ephodos.md` from `# Ephodos in lean-dir — the workflow` on), never to load the grokkings in full (Kooshi's decision 2).
      A `general-purpose` agent carries the Agent tool, so the no-spawn rule (`plans/STANDING-RULES.md` rule 1) is the brief's to state.
   4. Each era lane then runs pass 2 and pass 3, then the record job, then the Lean backlog's input and the re-rank (plan § 3, § 6).
4. **Kooshi's order** (2026-10-03): FS-129; then **the Lean backlog**, in a session of its own, from the input FS-129 prepares
   (`plans/LEAN-BACKLOG.md`: the 77 results handed to de Bruijn and what they rest on, in dependency order, with FS-129's merges applied,
   and FS-129's own compositions); then Poros's ranking, whose top is FS-123, the (Q)-free ring.
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

- **The brief gate is fixed** (agent-forge `4bc0e1d`, imported here at `f556d80b`): the six defects filed today, and two found while
  fixing them. A brief launches on a pass; a failure judged false is noted in the brief and filed in agent-forge with a repro.
- **agent-forge is ten commits ahead of its origin** (the filings and the fix among them); pushing it is Kooshi's call.
- **The Searcher's identity** is a stub in agent-forge (`identities/_unnamed-searcher/README.md`), at Kooshi's word: probably not needed;
  fleshed out only if the lane shows it needs more craft.
- **The census** `tools/fs71_ledger_b_check.py --strict` checks derivation files against `LEDGER.md` § B, which stops at FS-116 and FS-121; it
  is no longer run at a filing, and a 3.1 derivation file will fail it by design.
