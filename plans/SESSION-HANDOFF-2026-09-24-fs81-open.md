# Session handoff: FS-81 about to open (2026-09-24)

*Written by the product owner before a compaction, for a reader with no conversation memory. It supersedes
`plans/SESSION-HANDOFF-2026-09-24-fs79-pre-close.md` and `plans/SESSION-HANDOFF-2026-09-23-fs79-open.md`. Kooshi's instruction: "Please
write the handoff, with that as the next target, then I'll compact and we can tackle it in a fresh session." "That" is FS-81, chosen
on a fresh Poros's advice with the owner concurring.*

## 0. First acts after compaction

1. **Nothing is running.** No agent is live, and no job holds the lock (`…/scratchpad/locks/heavy.lock`). FS-79 is **closed**: `LEDGER.md`
   rows 80–81, G73, FS-80 minted, and all 106 close-inventory items done.
2. **Everything is pushed** (Kooshi, 2026-09-24: "Yes, push. You can always push on this repo … just never force push without my
   auth"). **Standing rule from now on: push freely to this repository's origin (the backup remote); never force-push without his
   explicit authorisation.**
3. **Read, in order:**
   - `plans/STUB-quadratic-four-colour-classification.md` (FS-81, the milestone);
   - `plans/POROS-2026-09-24-next-direction.md` §5 (why it was chosen, and what the advisor pushed back on);
   - `plans/FS81-close-inventory.md`, opened at minting with 14 items;
   - `plans/FS79-invariant-question.md` §R-close;
   - `CLAUDE.md` G61, G71, G72, G73 and G62/G7;
   - WORKFLOW steps 3.1–3.3 and 5;
   - `plans/PROTOCOL-competitor-and-advisor.md` §1 (as amended at FS-79's close).
4. **Keep `plans/FS81-close-inventory.md` current.** Log every item the moment it comes up. You are its only writer until the close.
5. **Opening fixes, before briefing the planner,** so the planner reads a correct record (inventory items 2–4, 6):
   - **`CLAUDE.md` stale claims.**
     - Frontier item 10: ℚ(√47)'s prediction is exactly five, not "four or five … met".
     - The target paragraph's "one cheap exposed prediction left" (add ℚ(√47), √143, √311, √335, ℚ(√3,√5)).
     - G48's "so next ℚ(√167)".
     - FS-59's "falsification target" wording, in `CLAUDE.md`, `plans/FRONTIER-STUBS.md` and its stub.

     Run `tools/claude_md_fact_audit.py --base fad1c032` and `--dupes` (15) afterwards.
   - **P-G54:** Γ₂₃'s tight/slack sign at four colours, a character sum taking seconds. Score it into FS-79's §R-close errata, or log
     it in FS-81's inventory.
6. **Then open FS-81 at stage A** (§2).

## 1. Rules in force (unchanged from FS-79 unless marked)

| rule | source |
|---|---|
| Opus 5.5 for every role; replace, don't reuse, above ~500k tokens | Kooshi, 2026-09-22 |
| At most three agents at once; **no child spawns children** (say so, with the reason, in every brief) | Kooshi, 2026-09-23; `CLAUDE.md` § Delegation |
| The owner coordinates and reviews, and does not contribute; drive phase to phase without go-aheads; never amend; halt on an unexplained crash | Kooshi, 2026-09-23 |
| **Push freely to this repository's origin; never force-push without Kooshi's explicit authorisation** | Kooshi, 2026-09-24 |
| **No SAT solver runs from 2026-09-24 (FS-81's close) to 2026-10-01**; the week is algebra-only, advised by a fresh Poros (`plans/POROS-2026-09-24-algebra-week.md`); the solver column of `plans/FRONTIER-STUBS.md` marks which stubs it can run | Kooshi, 2026-09-24 (close inventory item 82); `CLAUDE.md` § Toolchain |
| Every derivation milestone runs WORKFLOW 3.3 (§IQ), scored with §G; G72's count at the close | Kooshi, 2026-09-23 |
| The close inventory is opened at minting and written to as items arise (WORKFLOW step 5) | Kooshi, 2026-09-23 |
| **New at FS-79: every hand-back is content-free, and every report goes by explicit SendMessage.** The harness delivers a hand-back to whichever agent last woke the sender (protocol §1 rule 1) | FS-79 incident |
| **New at FS-79: every result is stated at its exact scope and grade, in reports to Kooshi too.** A narrow-format no-go is not "a kind ruled out"; a single solver's UNSAT is not "provably" | Kooshi's question, 2026-09-24; FS-79 inventory item 97 |
| **New at FS-79: the owner plants one fault of its own in every new checker** and checks one step of every key claim | FS-73 lesson 7, applied throughout FS-79 |
| **Superseded 2026-09-24 (Kooshi): RAM is the discriminator, threads are not rationed** — `scripts/slot.py` (a ~100 GB global cap, per-job hard caps, pinned cores); /tmp and swap are RAM. See `CLAUDE.md` § Building | Kooshi, 2026-09-24 |
| Commit by explicit path; check every agent's hash against `git log`; frozen tools never edited (FS-79 added `tools/fs79_p0_check.py`'s and `tools/fs79_p3*` families as read-only for later phases) | standing |

**The lock:** `flock -w 1800 /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/locks/heavy.lock <cmd>`.
The session directory changes after a restart, so use the one the system prompt lists.

**Briefs as files.** For briefs over ~10 KB, write the brief into the recipient's own scratch directory and launch with a short prompt
that points to it. FS-79 did this for the competition, so no one retyped 40 KB, and the owner's directory stayed out of every
recipient's path.

## 2. How FS-81 should run

| stage | agents (at most 3) | what it does |
|---|---|---|
| **A: the plan** | a fresh de Bruijn planner and a fresh plan-phase Poros | The reframe: §G, §PA (read `[Johnson2000]` and `[Johnson2006]` first; they are the likeliest prior art), §IQ (the structural form: for which d is `Θ₃` empty?). Then the subplan. The planner hands back before the modeling passes. |
| **Phase 0: the `Θ₃` runs** | one implementer, which can start during stage A once the planner sends its spec | Exact `Θ₃` trees on every open lattice of the 25 open fields (list in the stub), reusing FS-73's and FS-79's tools by import. Every certificate goes through a frozen checker, with the owner's plant. Positive controls: ℚ(√167) and ℚ(√47). Negative controls: three-colourable fields. |
| **B: the modeling passes** | a fresh agent | light |
| **C: the family derivation** | one derivation agent (a competition only if it stalls, G51) | FS73-T41 with the twist as a parameter: which d admit both twists (the type-M rotation at `n = (d+1)/4`, and the `(1+i)(a − i√d)/b` twist with `a² + d = 2c²`), and do T41's four cases hold? |
| **D: the ℚ(√47) phase** | one implementer | FS-79's phase-0 screen at four colours for d = 47, then one refusal ask on the densest survivor, **priced** (G65's law is three-colour; measure the four-colour threshold) |
| **E: the close** | a fresh close planner, from `plans/FS81-close-inventory.md` | WORKFLOW 9, including G72's second count |

**Budget anchors (FS-79):**

| role | tokens | against a budget of |
|---|---|---|
| planner | ~230k | |
| plan-phase advisor | ~220k | |
| phase-0 implementer | ~320k | |
| modeling agent | ~255k | |
| competitors | 552k and 360k | 400k |
| competition advisor | ~315k | |
| P3 implementer | ~356k | 250k |
| P3b implementer | ~200k | |
| close planner | ~400k of context (harness counter ~600k) | |
| next-direction advisor | ~370k | |

## 3. What FS-79 taught the owner (apply these; FS-73's nine still stand)

1. **Check a brief's premise against its population.** The "high-rank, priced out" premise borrowed numbers from a rank-8 lattice and
   from three colours. The advisor caught it (FS-79 owner error 2).
2. **The inventory names held items by label only.** Owner error 1.
3. **Point every new exact tool at the open instances the day it lands** (G72's *Do*). The owner missed it once: P3's `Θ₄` tree was
   not aimed at the survivors until Kooshi asked.
4. **A one-period census cannot see looseness.** 4,490 Kempe-rigid orbits looked like rigidity, and one full-dimensional `Θ₄` cell
   showed `L21cc6506` loose. The owner had logged the route as "live" on that census.
5. **Calibrate a finder on known positives at the question's scale** before reading its nulls (P3b did this unprompted).
6. **State every result at its scope in reports.** Seven overstatements appeared in one morning report.
7. **`flock -w` whose wait expires exits without running:** a silent non-run.
8. **The verification phase can be decisive.** FS-79's decisive result, `L21cc6506` loose, came from P3, not from the competition.
   Budget a verification implementer.
9. **The competitor-and-advisor design converged twice on the frame** (FS-73's heights; FS-79's edge-height no-go). Priming by
   backstory produced a weak divergence (P-persona won, weakly). Whether FS-81 needs a competition at all is the planner's call; the
   advisor recommended none unless the family derivation stalls.

## 4. Where things stand

- **Ledger:** rows 1–81; row 81 is the last. **Grokkings:** G1–G73. **Stubs:** FS-1–FS-81, with FS-81 at rank 1.
- **`CLAUDE.md`:** about 260 KB against the 275 KB budget. The fact audit `--base fad1c032` passes; `--dupes` is at 15.
- **Last commits:** FS-81's minting (this handoff's commit), `f6456fbd` (the next-direction advisor's record), `fad1c032` and
  `d96af41d` (FS-79's close completed).
