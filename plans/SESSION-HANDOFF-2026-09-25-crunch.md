# Session handoff: the 16-hour crunch, ready to launch (2026-09-25)

*Written by the product owner (orchestrator) for a reader with no conversation memory. It supersedes
`plans/SESSION-HANDOFF-2026-09-25-fs89-stage0.md` (FS-89 is closed).*

## 0. First acts, after compaction

1. **Read** `plans/CRUNCH-2026-09-25-queue.md` §1, the operating protocol (the rest by address only);
   `data/crunch-2026-09-25/READY.md`, the launch order; and `data/crunch-2026-09-25/briefs/STANDING-RULES.md`.
2. **Launch the first five jobs at once** (all Opus, `run_in_background`). Each launch prompt is "Your brief is on disk: read <path> in
   full first", plus a few essentials lines:
   - J01 (`J01-band-to-nine-verifier.md`);
   - J02 (`J02-three-colours-stage0.md`);
   - J09 (`J09-three-colours-blind.md`);
   - J03 (`J03-M1-reframe.md`);
   - J04 (`J04-M2-kernel-reframe.md`).

   All five are under `data/crunch-2026-09-25/briefs/`. **J06** takes the first slot that frees.
3. **Keep agent ids** in the owner scratch file `…/scratchpad/owner-crunch/live-agents.md`, never in the repository, and never quote them
   to Kooshi.
4. **Per report** (at most 12 lines, in the protocol's form):
   - verify the commit hashes against `git log`, and push;
   - launch the next job from READY.md;
   - after every third report or every two hours, launch the **Sonnet clerk** (`J00-clerk.md`), telling it which jobs started since its
     last run.
   - **Never read a job's record into your own context:** it is the budget. For a key claim, check one step with a short script or a
     grep, or leave it to the job's blind verifier.

## 1. Rulings in force (Kooshi, 2026-09-25, unless marked)

| rule | source |
|---|---|
| **16 usage-hours remain this week.** Keep 4–5 agents running nonstop from the queue. Jobs may propose jobs, which I enqueue; no child spawns children. An overshoot of a 5-hour window can halt agents mid-job, so every job saves each stage. | Kooshi's message; memory `crunch-mode-2026-09-25.md` |
| **My context is the budget.** Sonnet for bookkeeping and easy reads; Opus for everything judged. Kooshi compacts me as needed. | Kooshi |
| **Staffing cap:** "Max 4 subagents for now", then "4–5 agents nonstop" for the crunch. | Kooshi |
| **The `CLAUDE.md` budget is 300,000 bytes** (commit 1263d964; the file at 275,129). Each close adds at most about 4,000 bytes net. | Kooshi |
| **Worktrees** (none by default): symlink `.lake/packages`, copy `.lake/build` (`cp -a`), one Lean build at a time. | Kooshi; `plans/CONSOLIDATION-PARALLEL-PLAN.md` §1 |
| **The ban on finite-witness search** holds to 2026-10-01. | `CLAUDE.md` § Toolchain |
| **At most three milestones open at once**, with no job building on another open milestone's unverified claim except as a named hypothesis. This is the planner's default reading of "4–5 agents nonstop"; **Kooshi has been asked to confirm.** | queue §1 |
| Unchanged: push freely, never force-push; commit by explicit path; frozen tools; `scripts/slot.py`; never `lake build`; halt on an unexplained crash; replace an agent above about 500k tokens by the harness's count. | earlier handoffs |

## 2. Decisions open for Kooshi (the defaults hold if he says nothing)

1. **Several milestones open at once** (WORKFLOW says one at a time). Default: run the queue as written, at most three open.
2. **The two Johnson papers.** Default: every affected row says "not claimed new while unread".
3. **FS-89 item 54** (M50's S₅ consequence, from reading to hand grade). Default: it stays a reading.
4. **Carried:** the name "de Grey's lattice"; FS-90's two sanctioned hours; FS-57's long SDP at 47, which stays out of the queue under
   the ban.

## 3. Where things stand

- **FS-89 is closed:** rows 95–97, G76 rewritten, `plans/FS89-close-inventory.md` items 1–54. **RQ₄ and RQ₅ are proved** (every four-
  and five-colour band character of the rational unit circle's ring is torsion plus archimedean; hand, one derivation, every lemma
  re-derived blind).
  - **Prior art:** not in Berend 1983, 1984 or ETDS 1984, and not in Furstenberg 1967; the method is Berend's.
- **The crunch plan:** `plans/CRUNCH-2026-09-25-queue.md` (the planner; commits b3cda901, d2e4dcca, f9f0f47f, cd7ded77) and
  `plans/POROS-2026-09-25-crunch-plan.md` (the advisor).
- **The next fact-audit base** is FS-89's closing commit. Find it with `git log --oneline -- plans/FS89-close-inventory.md`, the latest
  entry; a new milestone's inventory records its own base when it opens.
