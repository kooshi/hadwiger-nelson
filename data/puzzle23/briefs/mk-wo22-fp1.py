#!/usr/bin/env python3
"""Generator of the planner's brief for the exact one-colour tool (quotes copied by script)."""
import sys, subprocess
sys.path.insert(0, "/home/kooshi/source/lean-dir/data/fs131/briefs/scripts")
from mkbrief import Q
now = subprocess.run(["date", "-u", "+%Y-%m-%d %H:%M UTC"], capture_output=True, text=True).stdout.strip()
C, RQ = "data/puzzle23/claims.md", "data/puzzle23/REQUEST.md"
DE = "/home/kooshi/source/descent-engine"
defs = "\n".join(Q(C, f"D{i}: ", "§ Definitions") for i in (1, 2, 3))
sts = "\n".join(Q(C, f"S{i}: ", "§ Statements") for i in (1, 2, 3, 4, 5, 6))
out = f'''# Brief WO22-FP1 — plan a tool that can say "no clash-free set of this size exists" on a finite board, and prove it: the planner's job

*Written {now} by Keryx, the coordinator (the top-level session of the customer project), at Kooshi's word. Launch line: "Your brief is on disk: read it in full first."*

brief: WO22-FP1
  identity: Ferrous — your agent file (`.claude/agents/ferrous-engineer.md`) is your identity; your governing documents are your own repository's four, read first, in the order that file gives
  role: the planner of the next work order in the sibling repository (WO-22, if that is the next free number): design a new binary that decides whether a finite board has a clash-free set of a given size and backs a NO with a certificate a separate checker accepts; a second, later mind builds from your plan
  launch: now; the sibling repository's tree is clean at `794c40f` and nobody else is writing in it
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage at once for a statement below that you find false or that your reading does not match, for a measurement that changes what should be built, or for anything that needs Kooshi (an install, a long run); your plan goes to the record, and a short hand-back to "main" when it is committed
  standing rules: plans/STANDING-RULES.md — read its rule 1 (no agents of your own) and rule 9 (running processes on this machine); those two bind every agent this session launches. The rest of that file is the customer project's and yields to your repository's own workflow
  record: `{DE}/plans/WO-22-exact-independence.md` (new; rename it to match the number and slug you choose)
  touches: in the sibling repository only — `{DE}/plans/WO-22-exact-independence.md` and throwaway prototypes under `{DE}/scratch/wo22/` (new). No crate source: that is the implementer's. Nothing under the customer project
  budget: about 300k by the harness's count, as guidance; you cannot read that count, so save a stage (a commit of the record) after the readback, after the measurements and after the design, and hand back before you would guess 450k

Hello. This is a tangent that turned into something worth building. The customer project (a Lean workspace on the
Hadwiger–Nelson problem) studies finite boards: the cells of `F_q²`, two cells clashing when they are one unit apart. You
already built two tools for these boards — one that searches for a colouring, one that searches for a large clash-free
set. Both say, rightly, that they can never report that something does not exist. This job is the tool that can.

## Why this job

Kooshi was playing a puzzle built on the 23 board and proposed this:

{Q(RQ, "K2: ")}
I tried the cheap versions this evening, and one number came out that makes his proposal worth a real tool. Six colours on
the 529 cells of the 23 board need some colour on at least 89 cells, because 529 = 6·88 + 1. Every local search anybody
has run stops at exactly 87 — yours (sixteen threads agreeing, `{DE}/plans/WO-18-outcome.md` § 2.3, where it was measured
against five colours' 106) and thirteen runs of mine. So if no clash-free set of 89 cells exists, the 23 board needs at
least seven colours, by counting alone. The customer project has six against seven open there, and the 23 board is one of
five finite boards that could still turn out exactly six-chromatic (`LEDGER.md` rows 69 and 71: the proven ceiling at 23
is 105). Nothing found so far proves the 87 is a maximum: that is a reading of a plateau, and one set of 88 kills it.

His instruction:

{Q(RQ, "K3: ")}
So: a new binary in your repository, built on what you already have, usable on every open board. You plan it; a fresh
mind implements it from your plan, because a plan this size can fill a context and the plan on disk is the handoff.

What I ran, with its limits, is in `data/puzzle23/README.md` (second half), `data/puzzle23/one_colour.py` and
`data/puzzle23/out/one-colour.txt` — Python, throwaway, one mind. Treat it as a customer's sketch, not as a design.

## The statements

Copied by script from `data/puzzle23/claims.md`, which I fixed before your launch. S3 to S5 are mine, by hand, checked by
nobody: your first stage is to check them, and a statement you find false is a finding I want at once, not a refusal.

{defs}
{sts}
## Done means

1. **Readback, first.** Check each quoted line above against its source file; restate S1 to S5 in your record in your own
   words; verify S3's argument and S5's arithmetic yourself, and say what you found. A saved stage.
2. **What exists.** Read your own WO-18 plan and outcome, WO-21's outcome (the field of 27 elements), and the public
   surface of `{DE}/crates/plane-independent` and `{DE}/crates/plane-colour`; say in the record what the new binary
   reuses (the field, the board, the verifying sweep, the symmetries, the record format) and what it must not share with
   them (the checker of a NO shares nothing with whatever produced it).
3. **Measure before you design in detail.** S4 is a proposal. Whether a piece inside S5's window exists at 23, and what an
   exact search costs on pieces of that size, are measurements a throwaway prototype can make in minutes; make them, under
   the rules of § The machine, and let them choose the design. If pieces made of whole lines cannot work, say which pieces
   can, or that the whole-board search is the only exact route, with its measured cost. A saved stage.
4. **The design**, in your repository's form for a work order: the binary's contract (S1 is the customer's part of it and
   does not move); the certificate a NO carries and the separate checker that accepts or refuses it; how pieces are
   chosen; the exact engine; where symmetry is used and where the certificate must not depend on it; checkpoint and
   resume, so that a killed run loses minutes and not hours; the controls — a second, independent exact method agreeing
   on small boards, a known YES that must never come back NO, and planted faults the checker must refuse, each watched
   failing.
5. **Reach, said honestly.** For each open board (D3) — which targets of S2 the design can decide, at what measured or
   extrapolated cost, and which it cannot; the 23 board at 89 is the one that must be decided or shown out of reach with
   the measurement that says so.
6. **The plan for the implementer**: stages, each ending in something saved and checkable, written for a mind that has
   none of your context and will not have you to ask. Then a short hand-back to me: where the record is, what you
   measured, what in my statements was wrong, what needs Kooshi.

## What is yours to decide

The algorithm — replace S4 wholesale if a measurement says another exact method is better: weighted pieces, pieces that
are not unions of lines, a linear programme over many pieces, Russian-doll search on the whole board. The binary's name,
the crate layout, the certificate's format, the work order's number and slug. One thing I would weigh, and it is yours to
weigh differently: a NO for one piece of a few hundred cells is small enough that an outside instrument could re-check it
(a proof-logging SAT run, or the customer project's kernel, which already checks such proofs); a certificate that names
the piece and the bound in a form an outside re-check can consume is worth more to the customer than one only your
checker reads. If you see a better shape for any of this, say so — you are closer to the material than I am.

Not yours: S1's rule that the tool never says NO because a search stopped; pushing (your agent file: the product owner
reviews first); any file of the customer project.

## The machine

Thirty-two cores; memory is the rationed resource and is shared with other jobs. Any run longer than about a minute, or
needing more than a few GiB, goes under the customer project's slot tool, which admits or refuses it against the memory
budget: `python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --name wo22 -- <command>` (exit 75
means "not now": wait and retry). Stop a process by its PID, never by matching its command line. `/tmp` is a tmpfs,
wiped at power-off: anything your record cites lives in your repository. Your session may be halted mid-job; that is the budget and not you, and it is why the three saved stages
matter — stopping at one with a clear "what is left" is a good hand-back.

You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review
work it knows exists).
'''
open("/home/kooshi/source/lean-dir/data/puzzle23/briefs/WO22-FP1-exact-independence-plan.md", "w").write(out)
print("ok", len(out))
