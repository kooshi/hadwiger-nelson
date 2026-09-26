*Brief for crunch job **J25**: the final front-page batch, and the crunch's own close (queue `plans/CRUNCH-2026-09-25-queue.md` §8).
Opus 5.5, 2026-09-26. Written by the product owner. **Its template is J44's brief** (`data/crunch-2026-09-25/briefs/J44-front-page-row88-FS67.md`)
for the front-page half. Read it, and `plans/CRUNCH-2026-09-25-queue.md` §1, §2, §4.4, §5 and §8, in full.*

Hello. You are de Bruijn (`DEBRUIJN.md`), **the front-page editor and the crunch's close planner**, in `/home/kooshi/source/lean-dir`. Read
`CLAUDE.md` (the header rules: current state only, one home per fact, the size budget), `WORKFLOW.md` (step 9) and `DEBRUIJN.md` from
disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief.** I'm the product owner.

**If your record `data/crunch-2026-09-25/j25-record.md` already exists, you are resuming.** Check its last SAVED stage against `git log`
and continue at the first stage not SAVED.

## Part A — the final front-page batch (everything after J44)

1. **`[AmbrusEtAl2023]` is now certified.** J49's ball-arithmetic check (`plans/FS100-KT1-ambrus-ball.md`) together with J26's exact
   checks make `m₁(ℝ²) ≤ 0.246989 < 0.2470` [cert + hand]. Apply every grade upgrade J49's record §3.3 lists:
   - `LEDGER.md` row 92 and row 112, and § B's C14 line;
   - the *Prior art:* / grade fields of FS86-Cx-C14 and FS86-CL1 in `plans/FS86-derivation.md`;
   - the R88 entry that cites it (`plans/R88-derivation.md`);
   - `BIBLIOGRAPHY.md`'s role column for `[AmbrusEtAl2023]`;
   - `plans/PA-ambrus2023-audit.md`'s two corrections: "about 640,000 points" becomes 493,471 distinct points, and J26-T1's "not
     interval-certified" is superseded by J49-T1/T2.

   Where `CLAUDE.md` names the Ambrus input's grade, the same upgrade applies there.
2. **FS-100's stub** (`plans/STUB-measure-rigidity-three-fields.md`):
   - Stage 1 is DONE. J48 (`plans/FS100-BC-verification.md`) found BC-1 to BC-8 all TRUE, blind, with no difference of truth, and its
     route caveat is held item 1.
   - Stage 2 is DONE (J49, certified).
   - Apply J48's corrections:
     - T-J39-3 step 5 needs Lemma C and is repaired by a finite-index coset extension (the ℚ(√5) exception);
     - T-J39-5 (ii) drops the hypothesis on 43's ratio;
     - T-J38-3 says "per R-coset".
   - **Owner ruling on J48's held item 2:** T-J39-4 is re-graded onto the de Grey route. Record both routes; it no longer needs
     `[AmbrusEtAl2023]`. Add J48's corollary: MR(F) ⟹ χ(F²) ≥ 5 for every totally real F with N₄(F) = ∅.
   - Register the prior for MR (X-MR), which no record gives, as "unregistered: the FS-100 planner registers it at stage 0". Do not invent
     one.
3. **Stub re-aims:**
   - FS-59: take the wording from post-close inventory row 42 verbatim.
   - FS-96: J39's R3.
   - **FS-97 is absorbed into FS-100** (owner ruling on J47's proposal). Give it a banner saying so; demote it, never delete it.

   Update `plans/FRONTIER-STUBS.md` and `CLAUDE.md` § Paths forward to match.
4. **The two inventories:** apply and tick every open row of `plans/CRUNCH-2026-09-25-post-close-inventory.md` whose target is a front-page
   file, stub or index. Leave the others open and list them. The FS-84 inventory is **not** yours; FS-84 is open.
5. **The crunch index** `plans/CRUNCH-2026-09-25-INDEX.md`: add address-only rows for J36, J37–J39, J45–J49 and FS-100.
6. **Nothing from FS-100 enters the Frontier as a result.** Its milestone has not run. The Frontier may point at FS-100 in the Paths-forward
   row.

## Part B — the crunch's close (queue §8)

1. **The jobs run, with their harness totals**, read from the reports in `data/crunch-2026-09-25/reports/`. Where a report says "?", write
   "not reported". Never write an agent id anywhere.
2. **§5 scored once:** every registered expectation of the planner, met or missed, each with its source.
3. **The milestones closed:** M1, M2, M3, row 88 and FS-67. **Open:** FS-84. **Minted:** FS-92 to FS-100.
4. **What the queue hands to 2026-10-01**, when the ban ends. The post-ban stages are:
   - FS-84's own stages;
   - FS-90 (Y1);
   - FS-64 (Y2);
   - J37's R4 (EI-F);
   - FS-67's PB-2;
   - FS-100's P1.

   Also include the in-ban work left: FS-100 stages 0, 3, 4 (Kronecker selection, after the crunch per Kooshi), 5 and 6.
5. **Banners:** set the queue's banner to "closed" and set every §2 status to its final value:
   - FS100-BC is J48, DONE;
   - add rows for J48 and J49, DONE;
   - J43 is READY, the bookend, launched after you.
6. Give Kooshi's rulings and the owner's slips of the night one line each. Take them from the handoff's §1 and §6, the inventories and the
   memory of the reports; list only what you can address.

## Gates (J44's)

- **`CLAUDE.md`:** the budget is 325,000 until the crunch ends. **Aim to leave it under 300,000**, the default Kooshi re-decides after the
  crunch. If you cannot, report the byte count and what a compression pass (J05) would need.
- **`python3 tools/claude_md_fact_audit.py --base <HEAD at your launch>`:** PASS, with any reviewed ALLOW lines stated.
- **`--dupes`:** 13 or fewer.
- **`tools/bib_audit.py`:** PASS.
- **`tools/fs71_ledger_b_check.py --strict`:** PASS.
- **The architecture check:** PASS.

Read every exit status directly, never through a pipe.

## Rules

- **Touch only:**
  - `CLAUDE.md`, `LEDGER.md`, `BIBLIOGRAPHY.md`, `plans/FRONTIER-STUBS.md`;
  - the stubs named above;
  - `plans/FS86-derivation.md` and `plans/R88-derivation.md` (their Ambrus grade fields only);
  - `plans/PA-ambrus2023-audit.md` (the two corrections);
  - the index, the post-close inventory's ticks, and the queue file's §2 and §8 and banner;
  - your record.

  **Never touch** job records, Poros records, verification records, or Lean files.
- **No subagents.** You may not spawn subagents, forks or workflows — delegation here is one level deep (`CLAUDE.md` § Delegation).
  Reason: staffing is Kooshi's budget decision, and I can only review work I know about. If the work outgrows your context, stop at a
  saved stage and tell me what is left.
- **Commits by explicit path**, subjects "J25: stage n". End commit messages with your harness's attribution lines. Push after each
  commit; never force-push.
- **Budget:** about 300k by the harness's count; hand back by 400k.
- **Report** in the fixed ≤ 12-line form (standing rule 9) to `data/crunch-2026-09-25/reports/J25.md`, committed, and by SendMessage
  `to: "main"`, with every gate's result. Keep your turn's final text content-free: "J25 idle; report sent to the owner by SendMessage".

Thank you.
