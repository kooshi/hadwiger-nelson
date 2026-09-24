# Session handoff: FS-85 about to open (2026-09-24)

*Written by the product owner for a reader with no conversation memory. It supersedes
`plans/SESSION-HANDOFF-2026-09-24-fs81-open.md`, whose §1 rules table and §3 lessons still apply except where this file updates them.*

**Current state (updated 2026-09-24 night; read before §0):** stages A and C and the first blind verification are done; every
record is in the repository (`plans/FS85-C-*.md`, `plans/FS85-V-verification.md`, `plans/POROS-2026-09-24-fs85-*.md`, `data/fs85/`).
Round 3 is running: the 5-part lemma (proved, `plans/FS85-R3-five-part.md`) now under a second blind verifier
(`data/fs85/briefs/V2-verifier-brief.md`, record `plans/FS85-V2-verification.md`), and an input audit (`plans/FS85-input-audit.md`).
The close inventory, `plans/FS85-close-inventory.md`, is the full state. The close is due by 2026-10-01.

## 0. First acts

1. **Nothing is running.** The slot ledger is empty (`scripts/slot.py --status`) and no agent is live. **FS-81 is closed**:
   - `LEDGER.md` rows 82–84 and G74;
   - `plans/FS81-quadratic-four-colours.md` §R-close;
   - `plans/FS81-derivation.md` T1–T25.
2. **Everything is pushed.** Push freely to this repository's origin; never force-push without Kooshi's explicit authorisation.
3. **The finite-witness-free week runs 2026-09-24 to 2026-10-01** (`CLAUDE.md` § Toolchain, with Kooshi's scope confirmed):
   - no SAT, MaxSAT or #SAT;
   - no MILP/CP or local-search colourers;
   - no Θ relation trees or float finders;
   - no quotient-colouring searches or survivor sweeps.

   Allowed: derivation, computer algebra, colourings given by formula, the Lean kernel, existing checkers on existing certificates,
   and exact LPs only when a derivation fixes their shape first. **Every brief carries a "would have searched here" log.**
4. **Read, in order:**
   - `plans/STUB-four-colour-rigidity-without-triangles.md` (FS-85, the milestone);
   - `plans/POROS-2026-09-24-algebra-week.md` §4–§6 (the premise check, the ranking, the scope, the verdicts);
   - `plans/FS85-close-inventory.md` (9 items; keep it current, since you are its only writer until the close);
   - `plans/STUB-algebraic-explanation.md` (FS-74, absorbed as step 1);
   - `plans/FS81-quadratic-four-colours.md` §R-close;
   - `CLAUDE.md` G73, G71, G74, G70, G55, G57, G72, G51;
   - `plans/PROTOCOL-competitor-and-advisor.md` §1 and its FS-81 run.
5. **Then open FS-85 at stage A** (§2).

## 1. Rules in force (new or changed since the FS-81 handoff)

| rule | source |
|---|---|
| **Resource rule:** threads are not rationed, RAM is. Any job over about 2 GiB or 2 minutes runs as `scripts/slot.py --mem <GiB> --cpus <N> -- <cmd>`: a ledger with a 90 GiB budget and a 25 GiB MemAvailable reserve, a hard MemoryMax cap with no swap, pinned cores, and a loud exit 75 if not admitted. A Lean build reserves and caps at the same number (`slot.py --mem 60 --cpus 16 -- env MEMMAX=60G ./scripts/build.sh`). **/tmp and swap are RAM**, so large outputs go to disk. The single `flock` heavy lock is retired. | Kooshi, 2026-09-24; `CLAUDE.md` § Building |
| **The finite-witness-free week**, as above | Kooshi, 2026-09-24; `CLAUDE.md` § Toolchain |
| `systemd-run` expands `$` in a command's arguments unless given `--expand-environment=no`; `slot.py` passes that flag | found 2026-09-24 |
| Value precedence with pins ranges over the unpinned colours only | FS-81 close; `CLAUDE.md` § Toolchain |
| Unchanged from before: at most three agents at once, all Opus 5.5, no child spawns children (say so, with the reason, in every brief); replace rather than reuse an agent above about 500k working tokens; content-free hand-backs, every report by SendMessage; every result at its exact scope and grade; the owner plants one fault in every new checker and checks one step of every key claim; commit by explicit path; never amend; frozen tools never edited; halt on an unexplained crash | earlier handoffs |

## 2. How FS-85 should run

| stage | agents (at most 3) | what it does |
|---|---|---|
| **A: the plan** | a fresh de Bruijn planner and a fresh plan-phase Poros | The reframe (§G, §PA, §IQ), kept short because the week is short. §PA reads Hubai 2018 (the held Polymath16 threads) and de Grey 2026 first. The subplan designs the competition, with the §C text for two briefs and the advisor's slots. Hand back before the modeling passes; the passes may be light or folded in, the planner's call. |
| **C: the competition** | two competitors (de Bruijn, Coxeter; optionally primed differently) and one advisor | Step 1 (Hubai's stripes on de Grey's lattice, and where the triangles enter) and step 2 (triangle-free four-colour rigidity), per the plan. Retractions counted. **The killing test is at about day 2.** |
| **Fallback** | one derivation agent plus a blind verifier | FS-83 (character colourings at four and five colours), if the killing test fires |
| **E: the close** | a fresh close planner, from `plans/FS85-close-inventory.md` | WORKFLOW 9, including the week's verdict (Paid, Draw or Null) and the search log's count |

**Budget anchors (FS-81):**

| role | working tokens | harness counter |
|---|---|---|
| planner | about 230k | about 600k |
| plan-phase advisor | about 200k | about 400k |
| phase-0 implementer | about 265k | about 574k |
| modeling agent | about 230k | about 386k |
| blind verifier | — | about 520k |
| stage-D implementer | about 345k | about 570k |
| close planner | about 350k | about 508k |
| algebra-week advisor | — | about 412k |

The advisor estimated FS-85 at 1.0–1.6 million tokens over 3–5 days.

## 3. What FS-81 taught the owner (apply these; the earlier lessons still stand)

1. **A reframe at the right level can finish the milestone on day 1.** The planner's field-level §IQ produced a proof before the plan
   was written. The remedy that worked was a **blind verifier** (the V2 pattern): it wrote predictions first, derived with the sketch
   closed, then compared. It found 14 divergences of route and none of truth. Use it again for any result the team likes.
2. **Plant in every new checker, and mutation-test the self-test.** A high-side coverage mutant passed the new checker's self-test,
   and the frozen FS-73 checker's self-test is blind to both coverage mutants (FS-81 item 38).
3. **Contended times inflate 2–3×** (FS-81 item 84). Re-ask every decision number on a quiet machine, with the ledger's status beside it.
4. **Check a stage's obligations for feasibility before briefing it.** D2's matched-control obligation (n within a factor of 2) was
   infeasible at ×1,284 (item 86). The price became a size ratio.
5. **Read the chapter after the one you read.** Soifer's Open Problem 55.1 sat one page after a chapter FS-70 read in full, and no
   file cited it until the algebra-week advisor found it.
6. **The owner's corrections are fallible.** Correction 2 described the wrong object (item 51), and the modeling agent caught it.
7. **Once the close planner starts, route items to it.** The inventory changes writers at that point.

## 4. Where things stand

- **Ledger:** rows 1–84. **Grokkings:** G1–G74. **Stubs:** FS-1–FS-85, with FS-85 chosen and FS-74 absorbed.
- **`CLAUDE.md`:** about 273 KB against the 275 KB budget, so the next close must compress without loss.
- **The fact audit:** `--base fad1c032` passes. `--dupes` stands at 13.
- **The next close's audit base:** the commit that minted FS-85 (this handoff's commit; find it with `git log --oneline -- plans/SESSION-HANDOFF-2026-09-24-fs85-open.md`), since `CLAUDE.md` changed after FS-81's close (the ban's scope and the next-milestone sentence).
- **Open debts:** the Johnson papers (Kooshi obtaining); the G72 counting proposal (Kooshi's call).
