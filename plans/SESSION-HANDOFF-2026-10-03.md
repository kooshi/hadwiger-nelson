# Session handoff — 2026-10-03: FS-129 is Derived; the next session opens FS-131, the Lean backlog

*Rewritten 2026-10-04 03:50 UTC by Keryx at Kooshi's word ("Next up, the backlog. I'll start a new session for it. Please make sure everything is
in order."). Current state only; the day's history is in git and in `plans/FS129-close-inventory.md`. A successor arriving with nothing reads
this first.*

## 1. Read first

1. You are Keryx if your system prompt carries `# Keryx in lean-dir — the workflow` and says **Workflow 3.1**. If it does not, ask Kooshi to
   restart the session (a `/clear` does not reload the output style).
2. **No agent is running; the tree is clean; `main` is pushed.** FS-129, the cross-application audit, is **Derived** (merged as `1622cf48`): its
   record is `plans/FS129-derivation.md`, its inventory `plans/FS129-close-inventory.md` (items 1–173), its front-page rows `LEDGER.md` 149–154.
3. **This session opens FS-131, the Lean backlog** (Kooshi's order; a special case, unranked). Read, in order:
   - its stub, `plans/STUB-lean-backlog.md` — the request verbatim, what it works from, how a kernel milestone opens, the held items;
   - its input, `plans/LEAN-BACKLOG.md` — § How to read this file and § Cautions first (259 rows, every statement quoted by script);
   - `LEAN.md` (§ The gate, § Assumptions, § The kernel's cost model) and `.claude/agents/debruijn.md` § A kernel milestone.
4. **What to do first**:
   1. Open the inventory, `plans/FS131-close-inventory.md`, with its first commit; write there the rules that will judge the milestone (what
      "Closed" means here: every backlog row formalized in its merged form, or excluded with its reason, and the gate passing).
   2. Brief de Bruijn's opening job (`debruijn`, Opus): the kernel reframe (§G for the kernel grokkings, read by number; §PA, Mathlib's coverage
      and any formalization in print) and the plan — waves along the backlog's order, the skeleton with `sorry` at every leaf, a plan per leaf,
      and which outside theorems enter as axioms with their four items (`LEAN.md` § Assumptions). Gate the brief
      (`python3 .claude/skills/keryx/scripts/brief_gate.py all <brief>`) and launch.
   3. Then the implementer (`debruijn-implementer`, Sonnet) per wave, from the plan. A statement defect or missing lemma goes to an Ephodos job.
5. **At most three agents at a time** (Kooshi, 2026-10-03), the Searcher included. **FS-129 is Closed** when its compositions pass the gate here;
   tick its inventory then.
6. **Held for Kooshi, with defaults** (`plans/FS129-close-inventory.md` item 173): the order (the backlog, then FS-124 — stands); the finite-graph search toward six
   (`plans/SEARCH-QUEUE.md` row 3 — held); a blind second mind on FS129-OR1-QFREE (none); the prior-art debt of FS-129's entries (owed until
   publication).
7. **After the backlog**: FS-124, the (Q) ring, the top of Poros's ranking — its question posed in `plans/STUB-q-ring.md` § The question (Poros,
   2026-10-03); Poros's card 2 (`plans/POROS-2026-10-03-fs129-rerank.md` § 2.4) runs at its opening.

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

## 3. Open items (none blocks the backlog)

- **The Proof Atlas republish** (`plans/FS129-close-inventory.md` item 172): `visualizations/proof-atlas/index.html` is built and passes its checker
  (212 facts, 0 failed) but has not been looked at in a headless browser per theme (`visualizations/proof-atlas/README.md` § Updating at a close,
  step 5); two node labels (FS128, FS120) still carry their old names; then Keryx republishes to https://claude.ai/artifact/7zzeXoXvTLHzqf4mTQujzx.
- **The Searcher's next day**: `plans/SEARCH-QUEUE.md` row 6 (C-T-BIKE, FS-130's construction target) is open; row 3 is held.
- **agent-forge is ahead of its origin** (the brief gate's defect filings, U8 and U9 among them); pushing it is Kooshi's call.
- **The census**, `tools/fs71_ledger_b_check.py --strict`, is not run at filings (§ B takes no lines from Workflow 3.1 on).
- **`plans/BACKLOG-FOR-OPUS.md`** is an older, unrelated stub triage (2026-09-08), not FS-131's input.
