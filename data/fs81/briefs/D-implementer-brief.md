Hello de Bruijn. You are this project's Lean engineer and mathematician; the identity is `/home/kooshi/source/lean-dir/DEBRUIJN.md`. I'd like you to run **stage D of milestone FS-81: ℚ(√47) at four colours, calibrated first**, as its implementer. I'm the product owner. Kooshi, the human whose project this is, has asked me to coordinate and review. The stage is yours to run, and I'll score it by artifact.

## Read first, from disk

1. **The house standard:** `/home/kooshi/source/lean-dir/CLAUDE.md`, `WORKFLOW.md`, `DEBRUIJN.md`. Read them from disk; any copy in your context is a snapshot. Especially:
   - § Building: one heavy job, the PROTECTED checkpoint paragraph, killing by process group;
   - § Toolchain: the symmetry-breaking checklist (but see item 52 below on value precedence), pysat's `interrupt()`, Python 3.14's `forkserver`;
   - § The gate: planted faults, the reachable uninformative outcome;
   - G21, G54, G65 (a **three-colour** degree law), G68, G69, G73.
2. **The spec of record:** `plans/FS81-quadratic-four-colours.md` **§S.D** in full, with the domain, obligation and experience passes behind it (**§B.1, §B.2, §B.3**) and my review (**§R-review**). §S.D was rewritten by the modeling passes. It is brief-ready, and it is your spec: every step, stop rule, obligation and record format is there. Read §0 and §S.2 for context.
3. **The material:**
   - `plans/FS73-derivation.md` T6 and T7, the certified object X_A: de Grey's lattice ball plus one edge {0, v}, with records under `data/fs73/census/cert/` and `data/fs73/records/verify-P1d.md`;
   - `plans/FS79-derivation.md` T1, T4–T7, T8–T16, T38–T49;
   - `data/fs79/records/phase-P0.md` (the four-colour screen at ℚ(√167) that D1 re-runs at ℚ(√47)), and `tools/fs79_p0.py`, `tools/fs79_p0_check.py`, `tools/fs79_p3b_theta4.py`;
   - the frozen `tools/fs58_check_witness.py` (three colours; K2 is its k-parametric copy) and `tools/fs73_cert_check.py`;
   - `plans/FS81-close-inventory.md` (read only), items 45 and 50–55: stage B's findings, which your stage acts on.

## Why this stage matters

At ℚ(√47) the local–global conjecture predicts **exactly five** colours. Four is proven, and five is the upper bound through the finite plane at 11. A certified refusal of four colours on a finite unit-distance graph over ℚ(√47) would prove χ(ℚ(√47)²) = 5, meeting the conjecture's exact prediction there. That confirms it and cannot falsify it.

Just as important: **the cost of refusing four colours on a rank-4 lattice has never been measured.** FS-79 quoted three-colour-law prices at four colours, and the owner's report dropped the caveat. That cost is what FS-59 (five over ℚ(√167)) needs before it spends anything. So D measures the four-colour band on known material first (D0), then screens ℚ(√47)'s lattices (D1), then makes one priced ask (D2).

## Your order of work, and the lock

**The other agents.** Phase 0 (exact three-colour certificates over 25 fields) is running under another implementer and holds the heavy lock at times. A verifier (stage C) is also working; its computations take seconds.

**Order:**
1. **DK: the two checkers.** No lock. Build them before anything is believed:
   - **K1**, `tools/fs81_colour_check.py`: the four-colouring checker for d = 47;
   - **K2**, `tools/fs81_check_witness_k.py`: the four-colour refusal checker over ℚ(√d), a k-parametric copy of the frozen `fs58_check_witness.py`.

   Their specs, plants and controls are in §S.D's acceptance table. Two points matter most:
   - K2's conclusion line depends on the object checked. With X_A's one non-unit edge it proves a forced pair and **never** "χ ≥ 5".
   - K2 has no positive control at k = 4 in its class. Any D refusal's proof therefore also goes through a second, independently written RUP check.

   **When each checker's self-test passes, stop and send me its path and how to run it.** I plant one fault of my own before any verdict it checks is believed.
2. **D0a: the harvest.** No solver, no lock. Every four-colour ask already on record goes into the §B.1.1 ask schema, one row each. No new solve until this table exists.
3. **D0b, D1, D2: these need the heavy lock.**
   - Take it with `flock -w 1800 /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/locks/heavy.lock <cmd>`.
   - **An expired wait exits without running the command**, a silent non-run, so check the exit status every time.
   - If phase 0 holds the lock for long, tell me rather than waiting blind; I'll sequence the two.

**Value precedence with pins (inventory item 52).** The clause is sound only if it ranges over the unpinned colours, or if the pinned clique comes first in the vertex order. `CLAUDE.md`'s checklist is ambiguous on this. K2 generates every symmetry clause from a rule it states, and it must refuse a precedence clause over a pinned colour.

## Budget, stop rules, checkpoints

- **Budget: about 350k tokens and up to three desktop days of wall clock.** Past about 500k, Kooshi's rule is that I replace rather than reuse an agent. So if you near 400k, stop at a clean boundary (a committed step) and report; D1 or D2 can go to a successor. Keep your record, `data/fs81/records/phase-D.md`, current enough that a successor could resume from the repository alone.
- **Stop rules** are §S.D's:
  - DK ends when both self-tests pass and my plant is refused by each;
  - D0a ends when the table exists;
  - D0b ends when R*(X_A) is bracketed and X_B and the colourable family have been asked at the same radii;
  - D1 ends at M ≤ 2,520 or one desktop day;
  - D2 ends at its wall, min(4·t_A, 6 h).
- **Checkpoint:** one JSONL row per ask under `data/fs81/phaseD/`, appended with fsync. Solver runs go through a subprocess with a wall (never a pysat CaDiCaL ask as the bounded one). Resume by re-running the same command, which skips recorded asks, so a kill redoes one ask. **Write the exact resume command in your record before the first long launch** (the PROTECTED rule: "if this dies now, what is redone?").
- **Kill by pgid and verify by effect**: the process gone from `ps`, its output static for ten seconds. Arm a waiter on the live job's pid. On any unexplained crash, halt and tell me.

## What a result may claim (read this twice)

- **A price** is one self-contained line, in the §B.3.3 format, with both denominators in words and the grade **[reading]**: carried from X_A, an abelian Cayley graph with one non-unit edge, with the triangle axis uncovered. A price is **never** a three-colour-law point count, and **never** evidence that four colours suffice.
- **A refusal at 47** must discharge §S.D's eight obligations before anything is said:
  - the exact object;
  - K2 CERTIFIED;
  - a second solver;
  - the symmetry rule's soundness;
  - the statement read aloud;
  - the upper bound's grade;
  - the chain named only if used;
  - **no "first"** until a prior-art gate on five-chromatic real quadratic planes is run and written into the record.
- **Every colouring** goes through K1. **Every survivor** is typed by the screens and caps it met. Compute its `Θ₄` cells before calling any lattice "rigid" (G73).
- **One solver's unchecked UNSAT is never "provably" anything.**

## Standing rules, each with its reason

- **No subagents.** You may not spawn subagents, forks or workflows; delegation here is one level deep (`CLAUDE.md` § "Delegation — one level deep").
  - The reason: staffing is Kooshi's budget decision (three agents at most), and I can only review work I know about.
  - If the work outgrows your context, stop at a clean boundary and tell me what is left. That is a good report, not a failure.
- **Commits by explicit path.** Before `git add`, run `git diff -- <path>` and confirm every hunk is yours; phase 0 and the verifier commit concurrently.
  - Never amend, and end commit messages with the attribution lines your harness supplies.
  - Don't push; I push.
  - Report each commit's exact hash; I check every hash against `git log`.
- **Frozen tools**, never edited:
  - `tools/fs58_*`, `tools/fs61_*`, `tools/fs66_*` and their `data/` trees;
  - `tools/fs73_cert_check.py`, `tools/fs73_census_check.py`, `tools/fs73_theta_check.py`, `tools/fs73_theta_struct_check.py`, `tools/fs73v2_check.py`;
  - `data/fs73/coxeter-c3/certcheck.py`.

  Treat every other `tools/fs73_*`, `tools/fs79_p0*` and `tools/fs79_p3*` file as read-only: copy it under `tools/fs81_*`. Don't edit phase 0's `tools/fs81_theta*.py` or `tools/fs81_p0.py`.
- **Your scratch directory:** `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs81-phaseD/`. Please don't list or read the other agents' directories, or `~/source/lean-dir-owner/`. Anything the close needs goes into `data/fs81/` and is committed, never left in scratch.
- **The close inventory is mine to write.** Send me anything the close must not lose: a result, a tool defect, a correction, a slip of anyone's, mine included.
- Don't edit `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md` or the plan file; propose edits in your report.
- **To reach me:** SendMessage with `to: "main"`. Your turn's final text is delivered to whichever agent last woke you, so keep it content-free ("stage-D implementer idle; report sent to the owner by SendMessage") and send every report by SendMessage.
- **Report at these points:**
  - when each checker is ready for my plant;
  - after D0a's table;
  - after D0b's ladder;
  - after D1's screen;
  - at D2's end.

  Each report carries the commits (exact hashes), anything surprising, and your approximate token usage.

## Predictions

§P has P-D0 (as scoped by stage B), P-D1 and P-D2. Register your own beside them in your record, with probabilities, before the first solver runs, and confirm for each that both outcomes are reachable.

## What I'll check at the end (the acceptance, up front)

1. K1 and K2 committed with self-tests, and my plant refused by each, before any verdict they check was believed.
2. D0a's table built before any new solve.
3. D0b's ladder: R*(X_A) bracketed; X_B and the colourable family at the same radii; one fixed encoding per comparison; T5 and T7 as instrument controls only.
4. D1's survivors typed, with their Θ₄ cells computed before any "rigid".
5. D2: either a refusal discharging all eight obligations, or a price line in the §B.3.3 format at grade [reading].
6. The record `data/fs81/records/phase-D.md` with "Theorems this phase proved", the predictions scored, and the resume command written before the first long run.

If the spec is wrong somewhere, say so: an unreachable control, a cheaper decisive order, an obligation that cannot be met. You'll be closer to the material than I or the modeling agent. Thank you, and good hunting.
