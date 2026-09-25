# Session handoff: FS-86 about to open (2026-09-25)

*Written by the product owner for a reader with no conversation memory. It supersedes
`plans/SESSION-HANDOFF-2026-09-24-fs85-open.md`. That file's §1 rules table and §3 lessons still apply, except where this file updates
them.*

## 0. First acts

1. **Nothing is running.** Check the slot ledger (`scripts/slot.py --status`). No agent is live.
2. **FS-85 is closed.** Read its results in:
   - `LEDGER.md` rows 85–87;
   - G75, new, and G54, rewritten;
   - `plans/FS85-derivation.md`, 39 entries;
   - `plans/FS85-rigidity-without-triangles.md`, **§R-close first**;
   - the close inventory `plans/FS85-close-inventory.md`, items 1–86, ticked.
3. **Everything is pushed.** Push freely to this repository's origin, and never force-push without Kooshi's explicit authorisation.
4. **Kooshi chose FS-86 on 2026-09-25:** four-colour rigidity over ℚ(√59) and ℚ(√83). Read, in this order:
   - `plans/STUB-dyadic-rigidity-triangle-free.md`: the milestone, its four routes, and its outcomes registered before any run;
   - `plans/FS86-close-inventory.md`: 7 items. You are its only writer until the close.
   - `LEDGER.md` rows 82, 85, 86, 87; `CLAUDE.md` G75, G54, G68, G69, G55, G57, G71, G73;
   - `plans/FS85-derivation.md` §7 (Coxeter's R2.6 reading) and the FS85-dB4 entry (the Soifer calibration);
   - `data/fs85/held/HELD-plan-advisor.md`, whose H5 and H6 are this milestone's origin, now public;
   - `plans/PROTOCOL-competitor-and-advisor.md`, including FS-85's run.
5. **Then open FS-86 at stage A** (§2).

## 1. Rules in force (new or changed since the FS-85 handoff)

| rule | source |
|---|---|
| **The finite-witness-free week ends 2026-10-01.** Until then: no SAT, MILP, Θ trees, finders, quotient-colouring searches or survivor sweeps. Derivation, computer algebra, formula colourings, the kernel and existing checkers are fine. The stub's route 4 (composite quotients) waits for the week's end. After 2026-10-01 the ban lapses by its own terms, unless Kooshi extends it. | `CLAUDE.md` § Toolchain |
| **"All novel knowledge is a success"**, and a proof that rules an approach out counts as one. Verdict labels score only an experiment. Tell agents not to lean toward a "yes". | Kooshi, 2026-09-24; memory `all-novel-knowledge-is-success.md` |
| **During a competition, competitor progress never goes into a file or commit subject the other side can read.** That rules out the close inventory in `plans/`, check scripts in `data/`, successor preambles in `data/`, and descriptive commit subjects. The harness shows every new agent the last five commit subjects at start-up, and an agent may run `git log` itself. Keep an owner-held scratch copy of the inventory, use neutral subjects ("bookkeeping (item N)") from the first competitive commit on, and restore everything at hand-back. | FS-85 items 49, 59; the protocol document; memory `competitor-advisor-protocol.md` |
| **Check a brief's statements yourself before copying an agent's wording into it.** FS-85's verifier-2 brief inherited R3a's overstated scope and a wrong ideal. The audit brief called a held page "not held". | FS-85 items 76, 78, 81 |
| **Registered verdicts must cover every reachable outcome, and a killing test must be able to fire.** FS-85's stub left "a result inside K only" unassigned, and its day-2 test could not fire. | FS-85 items 12, 22 |
| Unchanged from before:<br>• at most three agents at once, all Opus 5.5;<br>• no child spawns children (say so, with the reason, in every brief);<br>• replace rather than reuse an agent above about 500k tokens; round boundaries are the natural place, with a successor preamble in the agent's own scratch directory;<br>• content-free hand-backs, and every report by SendMessage;<br>• every result at its exact scope and grade;<br>• the owner checks one step of every key claim, in independent code where possible;<br>• commit by explicit path, never amend;<br>• frozen tools are never edited;<br>• the RAM rule (`scripts/slot.py`);<br>• halt on an unexplained crash. | earlier handoffs; `CLAUDE.md` |

## 2. How FS-86 should run (a proposal; the planner decides)

| stage | agents (at most 3) | what it does |
|---|---|---|
| **A: the plan** | a fresh de Bruijn planner and a fresh plan-phase Poros | The reframe (§G, §PA, §IQ). §PA reads the debts first: Soifer ch. 55's "[Soi46]"; de Grey 2026 and Haugstrup 2026 (the only triangle-free five-forcing mechanisms, both in ℝ³ or ℝ⁴); the Greenwell–Lovász / FS-67 product-rigidity literature. Register probabilities for the stub's outcomes (inventory item 4). |
| **B: the exact routes** | one derivation agent | Route 1, H5's falsifier: the Smith form on the dyadic tower of a rich lattice over ℚ(√59). Route 2: tightness level by level, with any slack level read against row 87's pull-back. Both are hours of exact computer algebra, in scope this week. |
| **C: the structural question** | two competitors plus an advisor, or one agent plus a blind verifier; the planner chooses by FS-85's evidence | Route 3: with no triangles there is no NT identity. What local linear identity, if any, pins the spectrum of a four-colouring of a triangle-free lattice? This is G75's killing test. A proved "no" in a named class is a result. |
| **V** | a blind verifier for any claimed yes | **A yes is Soifer-strength (FS85-dB4).** It needs two independent derivations and a blind verifier before any ledger row. |
| **E: the close** | a fresh close planner, from `plans/FS86-close-inventory.md` | WORKFLOW 9. |

**FS-85's evidence on staffing.**
- The competitors' first routes converged, and personas diverged them only weakly.
- The advisors caught two defects in the killing test and checked every step.
- Blind verifiers caught what the cross-checks missed: the wiki's proof defect, R3a's scope, and the P₋ notation.
- A cheap input audit made the headline "checked in full". A one-agent round with a blind verifier landed the last lemma in one stint.

## 3. Budget anchors (FS-85, harness counter unless marked)

| role | tokens |
|---|---|
| planner | about 330k working (610k harness) |
| plan-phase advisor | about 320k working (515k harness) |
| competitors, round 1 | about 310k working each; round-1 Coxeter 478k harness; de Bruijn through gap A 678k |
| Coxeter, round 2 | about 475k |
| competition advisors | 513k and 447k |
| verifier 1 / verifier 2 | 547k / 489k |
| round-3 derivation agent | about 373k |
| input auditor | about 220k context (640k harness) |
| close planners | 413k and 459k |

## 4. Where things stand

- **Ledger:** rows 1–87. **Grokkings:** G1–G75. **Stubs:** FS-1 to FS-88. FS-86 is chosen. FS-87 (the kernel chain) and FS-88 (Mixon's follow-up) are ranked.
- **`CLAUDE.md`:** about 274,600 bytes against the 275,000 budget. The next close must again compress without loss. FS-85's close found the lossless lever: items that retold ledger rows became pointers.
- **The fact audit:** `--base` for the next close is the commit that opened `plans/FS86-close-inventory.md`, since `CLAUDE.md` changed after FS-85's close. `--dupes` stands at 11.
- **Open debts:**
  - the Johnson papers (Kooshi obtaining);
  - the FS-86 reading (inventory item 5);
  - FS-87's kernel targets, starting with V2-T5, the stripe lemma.
