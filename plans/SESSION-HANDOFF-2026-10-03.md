# Session handoff — 2026-10-03: FS-116 and FS-121 closed; next, the workflow refinement

*Rewritten 2026-10-03 19:14 UTC by Keryx after both closes were filed (closing commit aa5a8e6e). Current state only; the history of the day is in git and in
the two close inventories. A successor arriving with nothing reads this first.*

## 1. Read first

1. You are Keryx if your system prompt carries `# Keryx in lean-dir — the workflow`.
2. **No milestone is open and no agent is running.** FS-116 (the local exclusion) and FS-121 (the map step) are closed undecided; their
   inventories (`plans/FS116-close-inventory.md`, items 1–156 with the W-table W1–W31 and the O-table O1–O8; `plans/FS121-close-inventory.md`,
   items 1–89) are ticked in full. The front page, `plans/FRONTIER-STUBS.md` (R2's re-rank) and the Proof Atlas (artifact
   https://claude.ai/artifact/7zzeXoXvTLHzqf4mTQujzx, version 5) are current.
3. **Kooshi's order for what comes next** (2026-10-03; FS-116 items O6, O7, verbatim there):
   1. **The workflow refinement**, with Kooshi: `plans/WORKFLOW3-lane-edits-proposed.md` (E1–E26, U1–U8, and the search-policy entry at its end).
   2. **FS-129, the cross-application audit** (`plans/STUB-cross-application-audit.md`), a special case outside the ranking.
   3. Then the top of the ranking; R2's default is **FS-123, the (Q)-free ring** (`plans/STUB-qfree-ring.md`), whose first question is R2's card 1
      on the bends.
4. **At most three agents at a time** (Kooshi, 2026-10-03; FS-116 item 74).

## 2. Decisions open for Kooshi (each with its default; FS-116 item 153, FS-121 item 87, FS-116 item O7)

- **The search ban.** Not deleted. Kooshi asked for a count first (CL3: of 981 logged search moves since 2026-09-24, 511 replaced by a result, 358
  wanted no search, 103 left open — 45 with nothing in their place — 9 unclear; FS-116 item O8, `data/workflow3/cl3/counts.md`), and is considering a
  wallclock budget per day and per week. Decided in the workflow refinement. Until then standing rule 5 and `CLAUDE.md` § Toolchain's ban paragraph stand.
- **The milestone after FS-129**: default FS-123 (R2, 0.7).
- **The cover route's parking**: default kept, now behind FS-125's NO-SAT.

## 3. Practices in force (each logged; most are proposed edits)

- The announcement rule (both inventories' tops): held = a frozen statement, two minds, the second blind, its verdicts committed before it compares.
- Frozen lists grow only by dated addenda; a decisive statement is frozen without its route's lemmas, and a route-naming phrase may be withheld for
  blindness and restored by a dated note when no blind job remains (FS-116 items 123, 147).
- A blind verifier's reading question: answered from the author's record when it has a defining sentence (quoted verbatim), else ruled an ambiguity.
- Brief tooling: `data/workflow3/brief_quote.py` fills "{{Q:file|heading|id}}" placeholders; known gate defects U3 (unwritten output paths), U5 ("…"
  inside a statement), U6 (a § address's number-stripped match: address "§ 14" alone), U7 (verdict words beyond "prove"/"confirm" pass);
  `data/rerank-2026-09-27/rk_mirror_check.py` is stale (W31).
- Commit subjects neutral while any blind job runs; times from `date` inside the writing command; agent ids only in the session scratch.
