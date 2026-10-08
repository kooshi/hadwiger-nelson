# Brief WO22-FP1 — plan a tool that can say "no clash-free set of this size exists" on a finite board, and prove it: the planner's job

*Written 2026-10-08 02:22 UTC by Keryx, the coordinator (the top-level session of the customer project), at Kooshi's word. Launch line: "Your brief is on disk: read it in full first."*

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
  record: `/home/kooshi/source/descent-engine/plans/WO-22-exact-independence.md` (new; rename it to match the number and slug you choose)
  touches: in the sibling repository only — `/home/kooshi/source/descent-engine/plans/WO-22-exact-independence.md` and throwaway prototypes under `/home/kooshi/source/descent-engine/scratch/wo22/` (new). No crate source: that is the implementer's. Nothing under the customer project
  budget: about 300k by the harness's count, as guidance; you cannot read that count, so save a stage (a commit of the record) after the readback, after the measurements and after the design, and hand back before you would guess 450k

Hello. This is a tangent that turned into something worth building. The customer project (a Lean workspace on the
Hadwiger–Nelson problem) studies finite boards: the cells of `F_q²`, two cells clashing when they are one unit apart. You
already built two tools for these boards — one that searches for a colouring, one that searches for a large clash-free
set. Both say, rightly, that they can never report that something does not exist. This job is the tool that can.

## Why this job

Kooshi was playing a puzzle built on the 23 board and proposed this:

> K2: It feels like the largest independent set could be solved by ehaustive exact search (with pruning and other optimizations) by a more traditional computer science algo rather than SAT.
> — source: data/puzzle23/REQUEST.md

I tried the cheap versions this evening, and one number came out that makes his proposal worth a real tool. Six colours on
the 529 cells of the 23 board need some colour on at least 89 cells, because 529 = 6·88 + 1. Every local search anybody
has run stops at exactly 87 — yours (sixteen threads agreeing, `/home/kooshi/source/descent-engine/plans/WO-18-outcome.md` § 2.3, where it was measured
against five colours' 106) and thirteen runs of mine. So if no clash-free set of 89 cells exists, the 23 board needs at
least seven colours, by counting alone. The customer project has six against seven open there, and the 23 board is one of
five finite boards that could still turn out exactly six-chromatic (`LEDGER.md` rows 69 and 71: the proven ceiling at 23
is 105). Nothing found so far proves the 87 is a maximum: that is a reading of a plateau, and one set of 88 kills it.

His instruction:

> K3: Have the lean engineer build the tool, using the algo you describe, in such a way that it can be used to solve any/all of our open primes. Technically it will require both a Ferrous planner and Ferrous implementer. It can just go into the descent engine repo as a new binary.
> — source: data/puzzle23/REQUEST.md

So: a new binary in your repository, built on what you already have, usable on every open board. You plan it; a fresh
mind implements it from your plan, because a plan this size can fill a context and the plan on disk is the handoff.

What I ran, with its limits, is in `data/puzzle23/README.md` (second half), `data/puzzle23/one_colour.py` and
`data/puzzle23/out/one-colour.txt` — Python, throwaway, one mind. Treat it as a customer's sketch, not as a design.

## The statements

Copied by script from `data/puzzle23/claims.md`, which I fixed before your launch. S3 to S5 are mine, by hand, checked by
nobody: your first stage is to check them, and a statement you find false is a finding I want at once, not a refusal.

> D1: For a finite field `F_q` with `q` odd, the board `Γ_q` is the graph on the `q²` cells of `F_q²` in which two cells `(x, y)` and `(x′, y′)` are adjacent (they *clash*) exactly when `(x − x′)² + (y − y′)² = 1` in `F_q`.
> — source: data/puzzle23/claims.md § Definitions

> D2: A set of cells is *clash-free* when no two of its cells clash; `α(Γ_q)` is the largest size of a clash-free set; for a set of cells `H`, `α(H)` is the largest size of a clash-free subset of `H`, and for a weight `w ≥ 0` on `H`, `α_w(H)` is the largest total weight of a clash-free subset of `H`.
> — source: data/puzzle23/claims.md § Definitions

> D3: The open boards are `q ∈ {23, 27, 31, 43, 47}`; `27` means the field with 27 elements, not the integers modulo 27.
> — source: data/puzzle23/claims.md § Definitions

> S1: DECIDE(q, t) asks whether `Γ_q` has a clash-free set of `t` cells; the tool answers YES with such a set, re-checked pair by pair from D1 by code that shares nothing with the search; or NO with a certificate that a separate small checker accepts; or UNDECIDED with what was measured; it never answers NO because a search stopped.
> — source: data/puzzle23/claims.md § Statements

> S2: `k` colours on `q²` cells put some colour on at least `⌈q²/k⌉` cells, so a NO at `t = ⌈q²/k⌉` proves that `Γ_q` needs more than `k` colours; the first targets are `t = ⌈q²/6⌉`, which is 89, 122, 161, 309, 369 at `q` = 23, 27, 31, 43, 47.
> — source: data/puzzle23/claims.md § Statements

> S3: (the ratio lemma; by hand, one mind, unchecked) Translations of `F_q²` are automorphisms of `Γ_q` and act transitively on its cells, so for every set of cells `H`, every weight `w ≥ 0` on `H` and every clash-free set `A` of `Γ_q`: `|A| / q² ≤ α_w(H) / w(H)`; with `w = 1` on `H` this is `|A| / q² ≤ α(H) / |H|`. Argument: sum the `w`-weight of `A ∩ (H + v)` over all `q²` translations `v`; each cell of `A` is counted with total weight `w(H)`, so the sum is `|A| · w(H)`, and each of the `q²` terms is at most `α_w(H)`.
> — source: data/puzzle23/claims.md § Statements

> S4: (the method as described to Kooshi; a proposal, not a requirement) a NO at `t` is proved by one piece `H`, plain or weighted, whose exactly computed `α_w(H)` is below `t · w(H) / q²`; the pieces to try first are unions of parallel lines in a direction that contains no clash step, each of which is clash-free on its own; the exact computation is classical branch and bound, Russian-doll search over nested unions of lines being the classical algorithm of this shape; the whole board with one cell fixed in the set, under the symmetries fixing that cell, is the fallback.
> — source: data/puzzle23/claims.md § Statements

> S5: (arithmetic at 23; by hand, one mind, unchecked, and it replaces a wrong sentence in the record) a clash-free set of 87 cells of `Γ₂₃` is known, so a plain piece proving NO at 89 has `87·|H|/529 ≤ α(H) < 89·|H|/529`; for a union of `j` whole no-clash lines that is `87j/23 ≤ α(H) < 89j/23`, whose integer solutions for `j ≤ 12` are `α(H)` = 19, 23, 27, 38, 42, 46 at `j` = 5, 6, 7, 10, 11, 12; since one whole line is 23 clash-free cells, `j = 5` is out, and `j = 6` needs six lines no two of which can be taken whole together; any such piece gives `α(Γ₂₃) = 87` outright.
> — source: data/puzzle23/claims.md § Statements

> S6: (what is already measured) at `q = 23` every run of two independent local searches stops at 87 cells and none reaches 88: the sibling repository's tool (16 threads agreeing) and thirteen runs of a Python tabu search; the best set invariant under a rotation of order 12 about a cell has exactly 85 cells; the certificate's ceiling is 105.
> — source: data/puzzle23/claims.md § Statements

## Done means

1. **Readback, first.** Check each quoted line above against its source file; restate S1 to S5 in your record in your own
   words; verify S3's argument and S5's arithmetic yourself, and say what you found. A saved stage.
2. **What exists.** Read your own WO-18 plan and outcome, WO-21's outcome (the field of 27 elements), and the public
   surface of `/home/kooshi/source/descent-engine/crates/plane-independent` and `/home/kooshi/source/descent-engine/crates/plane-colour`; say in the record what the new binary
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

## Amendment 1 (2026-10-08 03:17 UTC) — one more lever to price: a GPU for the heavy branch

Kooshi, reading your stage-2 measurements:

> K4: back on the field coloring: well... what if we pack it into a 3 bit representation (for up to 8 colors), and have a GPU kernel evaluate each board for clashes, and maybe have the CPU have each of the boards queued to push to the GPU? idk. depends on where the bottleneck is
> — source: data/puzzle23/REQUEST.md

His sketch is about colouring boards; I am passing it to you for the search you priced, because that is where a
bottleneck has been measured. My reading, unchecked: checking finished boards is never the bottleneck — what generates
them is — but the heavy branch of DECIDE(23, 89) has an inner loop that is a few ANDs and popcounts on a 529-bit mask,
and "the processor splits the tree into a queue of sub-boards, the GPU finishes each" is his sketch transposed to it.
This machine has two cards (`nvidia-smi` reports graphics card A with 32 GB and graphics card B with 24 GB).

**Asked of you, as part of the design's list of levers — to price, not to build:** what one node of the heavy branch
costs in word operations; what node rate a GPU kernel would have to reach for DECIDE(23, 89) to take days and whether
that is plausible for this kernel; how unevenly sized subtrees would be handed back and re-split; and what such a run
does to the certificate and its checker, which cannot log every node of a tree that size. Say where it ranks among
your other levers. If you think it is the wrong lever, say that and why — that is an answer.

Nothing else changes: the statements, the acceptance, the files you may write. A GPU toolchain or crate that is not
already on this machine is an install and needs Kooshi: name it in the plan, do not fetch it. You start no agents of
your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).
