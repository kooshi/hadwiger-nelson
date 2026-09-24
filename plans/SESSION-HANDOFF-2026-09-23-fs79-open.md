# Session handoff: FS-79 about to open (2026-09-23, night)

*Written by the product owner before a compaction, for a reader with no conversation memory. It supersedes
`plans/SESSION-HANDOFF-2026-09-23-fs73-mid.md`. **Kooshi's instruction for after the compaction: "all 4 of you can focus solely on
this"**, meaning FS-79. That is the owner plus up to three agents.*

## 0. First acts after compaction

1. **Nothing is running.** No agent is live and no job holds the lock (`…/scratchpad/locks/heavy.lock`). FS-73 is closed, and everything
   is pushed through this handoff's commit.
2. **Read, in order:**
   - `plans/STUB-invariant-question-four-colours.md` (FS-79, the milestone);
   - `CLAUDE.md` G72 and G71;
   - WORKFLOW step 3.3;
   - `plans/PROTOCOL-competitor-and-advisor.md` (the design, as amended at FS-73's close);
   - FS-73's record `plans/FS73-rigidity-dichotomy.md` §R-close.
3. **The owner's held items for FS-79** are at `~/source/lean-dir-owner/FS79-held-items.md`, outside the repository on purpose.
   - The owner reads them.
   - The planner, the plan-phase advisor and the competitors never do.
   - The competition-phase advisor gets them in its brief, to offer both competitors at once after each has written its own first
     route (FS-73's ruling R1).
4. **Then open FS-79 at stage A** (§2).

## 1. Rules in force

| rule | source |
|---|---|
| Opus 5.5 for every role (`model: "opus"`) | Kooshi, 2026-09-22 |
| Replace, don't reuse, any agent that returns above about 500k tokens | Kooshi, 2026-09-22 |
| At most three agents at once; **no child spawns children** | Kooshi, 2026-09-23; `CLAUDE.md` § Delegation |
| The owner coordinates and reviews, and does not contribute. Kooshi's "all 4 of you" means the owner plus three agents | Kooshi, 2026-09-23 |
| "I'll trust your decisions": drive phase to phase without asking for go-aheads. Never push unless told (each push is its own permission), never amend, and halt on an unexplained crash | Kooshi, 2026-09-23 |
| **Every derivation milestone's plan runs WORKFLOW 3.3 (§IQ)**; the owner scores it with §G | Kooshi, 2026-09-23; G72 |

**Every brief says:**
- that no child spawns children, with the reason (staffing is Kooshi's budget decision, and the owner can only review work it knows
  about);
- how to reach the owner (`SendMessage` with `to: "main"`);
- the lock: `flock -w 1800 /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/locks/heavy.lock <cmd>`
  for anything over about 2 minutes or about 8 GB. The session directory changes after a restart; use the one the system prompt lists.
- that the disk copy of `CLAUDE.md` is authoritative;
- that nobody runs `lake build`; use `./scripts/build.sh`;
- commit by explicit path, and check every hash against `git log`.

**Frozen tools** (never edited):
- `tools/fs58_*`, `tools/fs61_*`, `tools/fs66_*` and their `data/` trees;
- `tools/fs73_cert_check.py`, `tools/fs73_census_check.py`, `tools/fs73_theta_check.py`, `tools/fs73_theta_struct_check.py`,
  `tools/fs73v2_check.py`;
- `data/fs73/coxeter-c3/certcheck.py`.

## 2. How FS-79 should run

| stage | agents (at most 3) | what it does |
|---|---|---|
| **A: the plan** | a fresh de Bruijn planner, a fresh plan-phase Poros, and optionally the phase-0 implementer | The planner does the reframe: 3.1 re-grokking (§G), 3.2 prior-art gate (§PA), and **3.3 (§IQ)**, then the subplan and the competition brief (§C). The disciplines for §PA to search: hom-shifts and symbolic dynamics; Hom and box complexes (Lovász's topological method); height and flux mappings in statistical mechanics (Coulomb phases, Baxter, Moore–Newman); homomorphism duality and universal targets; decidability of periodic-graph colouring (`[Burr1984]` and its successors). Poros advises the planner and may hold its own items, as in FS-73. Neither reads the owner's held-items file. |
| **Phase 0: a measurement** | one implementer, run during stage A if the cap allows | A periodic four-colour screen of ℚ(√167) lattices, by rank, plus implementer C's residue-set rule (FS-73 P2b) re-run at four colours. It lists which lattices *could* need five colours, which is §IQ item 5 and feeds FS-59. It must not shape the competition's question. |
| **B: modeling passes** | the planner, or a fresh one above about 500k tokens | Probably light. It is a derivation milestone and may add no Lean; the planner says which passes apply. |
| **C: the competition** | fresh de Bruijn and Coxeter competitors, and a fresh Poros | Identical briefs written from §IQ. Working files and the advisor's record live in scratch until hand-back. The advisor's brief carries both held-item sets (the owner's and plan-phase Poros's). Retractions are counted. Each theorem's key step is re-derived by the other side or by Poros, plus one step by the owner. |
| **D: the close** | a fresh planner, from an owner-written inventory (FS-73's `plans/FS73-close-inventory.md` is the template) | WORKFLOW 9, including the re-read of §IQ: did the result come through the structural question? That is G72's first count. |

**Budget anchors from FS-73:**
- the plan-phase planner used about 580k tokens, too many; brief the plan and the modeling passes as separate agents;
- the competitors used about 360–410k each, over about 1.5 hours;
- Poros used about 480k;
- the two close planners used about 490k and 535k;
- the census implementers used about 400–560k.

## 3. What FS-73 taught the owner (apply these)

1. **Check a brief's premise against its scope before sending.** The P4 brief claimed the fixed-prime gap lemma covered rank-6
   lattices, and it doesn't. The implementer caught it.
2. **Private files never go in `plans/`.** Working files and advisor records live in scratch until hand-back.
3. **Grep the held Polymath16 threads for every headline object** (G49). Hubai had row 78's count in 2018, in
   `~/source/library/notes/polymath16-threads-1-18-text.txt`.
4. **Write the close inventory early,** as soon as the last agents are running, and have the close planner tick it.
5. **Verify every commit hash an agent reports.** Two agents reported hashes that did not exist.
6. **Stop a finished agent that keeps waking** (TaskStop) once its work is committed and nothing of its is running.
7. **For every result,** register the prediction before any run, have the owner check one step independently, and plant one fault of
   the owner's own in every checker.
8. **Killing a `flock` wrapper can orphan its child, which keeps the lock.** Kill the process group, and verify against the command's
   effect.
9. **Point every new exact decision procedure at the open-instance list the day it lands** (G72's *Do*). All three minds did this for
   ℚ(√167) independently.

## 4. Where things stand

- **Last push:** this handoff's commit. Before it, `ad314221` (the close) and `af9d9a3a` (G72, WORKFLOW 3.3, FS-79).
- **Ledger:** row 79 is the last. **Grokkings:** G72 is the last.
- **`CLAUDE.md`:** about 247.6 KB against the 275 KB budget. The fact audit `--base ad314221` passes; `--dupes` stands at 15 runs.
- **Ranked stubs:** 1 FS-79; 2 FS-74 (the algebraic explanation, Kooshi's) and FS-59 (five over ℚ(√167)); 3 FS-75 (the three-colour
  criterion in the kernel); 4 FS-76; 5 FS-78; 6 FS-77.
