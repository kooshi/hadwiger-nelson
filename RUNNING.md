# Running things here — the toolchain, processes, and instruments that must fail loudly

*Moved verbatim from `CLAUDE.md` § Toolchain, § Building and § Make the gate fail, and watch it fail on 2026-09-28, at Kooshi's word
("Do #2, #3, #4", answering item 3 of `plans/WORKFLOW-AUDIT-2026-09-28.md`: these sections were loaded into every agent though only the
jobs that run processes or build instruments use them). Every brief for a job that runs a solver, a build or a long process, or builds a
checker, names this file as part of it; the rules every job needs are `plans/STANDING-RULES.md` rule 9. Two paragraphs of § Building are
**PROTECTED**, and their tags bind here exactly as they did in `CLAUDE.md`. Where the moved text says "this file" or "this page", it
meant `CLAUDE.md`; its `§` references without a file name are to the sections below, and to `CLAUDE.md` for § Searching and § The gate.
Its second and later instances stay in `plans/GROKKING-INSTANCES.md`. Keryx is this file's writer.*

## Toolchain

**The SAT solver.** The toolchain ships **`cadical`** (2.1.2, LRAT-capable) at `$(lean --print-prefix)/bin/cadical` — that command
works only from inside the repository; elsewhere use the path under `~/.elan/toolchains/`. It is single-threaded: use
`tools/portfolio.sh` (a configuration race) and colour-cube splits (one run per cube) to use the cores.

**What else is installed on the desktop** (inventory of 2026-09-21; Kooshi installs on request — *ask, with the reason*; verify with
`command -v` before planning around any of it, and **a tool that is missing fails silently behind a pipe**: `/usr/bin/time` and `bc` were
both absent until 2026-09-21 and turned three timed runs into non-runs that read like slow solvers):

| kind | tools |
|---|---|
| SAT | `kissat` 4.0.4 (AUR; the strongest refuter), `cryptominisat5` 5.15, toolchain `cadical` 2.1.2; **PySAT** (`pysat` 1.9, system Python): `cadical103/153/195/300`, `glucose3/4/42`, `minisat22`, `maplechrono`, `maplecm`, `maplesat`, `mergesat3`, `lingeling`, `kissat404`, `cryptosat`, cardinality-aware `minicard`/`gluecard3/4` — four code bases in one process is the standing multi-solver recheck. **Not installed; build from source when wanted:** `march_cu` (lookahead cuber), `cake_lpr` (formally verified LRAT checker), `drat-trim`, BreakID |
| optimisation | `scip` 10.1 (exact global optimisation, non-convex QCQP; open source). By `pip` into a venv: `pyscipopt`, and `gurobipy`, whose **size-limited licence stops at 2,000 variables or constraints** |
| semidefinite | The symmetry-reduced moment relaxation and its exact certificate: `tools/fs66_b1_cert_make.py` + frozen `tools/fs66_b1_cert_check.py` (Python; no Julia needed to `n = 529`; costs in row 75's plan §R‴). SCS in `build/venv-sdp` (CPU), `build/venv-sdp-mkl`, and **`build/venv-sdp-gpu`** (GPU-indirect source build; keyword `linear_solver=`; 0.33 s/iteration at 83 on card A). `cvxpy`, `clarabel` by `pip`. **Julia 1.13** (`julia`): `SumOfSquares.jl` + `SymbolicWedderburn.jl` reduce a moment/SOS relaxation by its symmetry automatically — the step FS-50 did by hand — and `Clarabel`/`Hypatia` solve in `BigFloat`, which is what makes rounding to an exact certificate easy |
| algebra | `gap` 4.16, `gp` (PARI 2.17; `nflist`), `dreadnaut` (nauty 2.9), `sympy` |
| build, GPU | `cargo`/`rustc` 1.98 (the tabu finders `plane-colour`, `plane-independent` live in `~/source/descent-engine`, fields only — a ring `ℤ/p^r` is refused by design), `nvcc` (CUDA 13.4, `/opt/cuda/bin`), `gcc`, `clang`, `cmake`, `ninja`, `uv`, `pip`, `paru`; Python 3.14 with `numpy` 2.5, `scipy` 1.18 — **no `torch`, no `cupy`** |
| shell | GNU `time` 1.10 at `/usr/bin/time`, `bc` — and `grep -E` here is `ugrep` (§ Searching) |

**A pysat solver's interrupt is per back-end** (FS-79 phase 0): pysat's CaDiCaL back-ends ignore `interrupt()` — "Limited solve is
currently unsupported by CaDiCaL" is raised inside the timer thread, so a Timer budget never fires and the solve runs unbounded. Bound a
pysat CaDiCaL ask by a parent-enforced subprocess timeout (external kissat or cadical), or use a back-end that supports `solve_limited`.

**Venvs and package depots live outside `build/`** when anything unrecoverable is in them (`build/` is scratch that agents clean); the three `venv-sdp*` are regenerable.

**Break the symmetry before any (UN)SAT search, and treat an unbroken encoding's verdict as a measurement of the
encoding** (Kooshi, 2026-09-15). These graphs are vertex- and arc-transitive with interchangeable colours, so a naive
encoding asks the solver to re-derive the same contradiction once per symmetric copy. The checklist, cheapest first:
1. **Pin a maximal clique.** The origin takes colour 0 (vertex-transitivity) and one neighbour takes colour 1
   (arc-transitivity). **Check `ω` first, because it bounds what this can buy**: `ω(Γ_q) = 3` iff the
   characteristic is 3 or 3 is a square in `𝔽_q`, else 2 (`[Krebs2022]`, verified here at 21 planes). Where `ω = 3` a
   triangle pins three colours; where `ω = 2` — 7, 17, 19, 31, 43, 67, 79 among them — **an edge is all there is, and the
   clique pin is therefore weak**.
2. **Break the residual value symmetry, which the clique pin does not reach.** After pinning `k' ≤ ω` colours the
   remaining `k − k'` are still freely interchangeable — `3! = 6` at `(17, 5)`. A precedence constraint **over the unpinned colours only** kills it: for each unpinned colour `c` above the first, `c` may appear at `v` only if `c − 1` appears strictly earlier (`¬x[v][c] ∨ ⋁_{u<v} x[u][c−1]`) — or put the pinned clique first in the vertex order. A chain that reaches down to a pinned colour, with the pinned vertices later in the order, forbids colourings no permutation repairs: an unsound encoding (FS81-T20, found by FS-81's modeling agent).
   **Measured 2026-09-15: `(13, 5)` 251.09 s → 3.48 s, a 72× speedup, and `(17, 4)` 38.35 s → 11.55 s.** The 3.48 s
   also reproduces M58's independently recorded 3.8 s for that instance, which is the control.
3. **Then the cores:** `tools/portfolio.sh` for a configuration race, and cube-and-conquer for a hard instance — but
   **price the cubes on a sample before committing** (M63 phase H2 priced 552 cubes before spending 20 core-hours).
4. **Never report an `UNKNOWN` at a budget from an unbroken encoding as a fact about the graph.** It is G21's rule in
   solver clothes: the verdict measures the enumeration, and an unbroken encoding's enumeration is `|Aut| × k!` times
   larger than the question.


**Python is 3.14, and its multiprocessing default changed.** On Linux the default start method is now
`forkserver`, not `fork` (measured: 3.14.6), so a worker **re-imports the module** instead of inheriting the
parent's memory, and state a parent leaves in a module-level global is **empty in the worker** — the symptom is
a `KeyError` on a key the parent plainly holds, nowhere near the process model. Pass
`mp_context=multiprocessing.get_context("fork")` (safe with no threads), or give the pool an `initializer` that
rebuilds the state from picklable arguments, which also survives a platform without `fork`.

**Two machines.** A desktop and a laptop (12 cores, 31 GB). The desktop has **16
PHYSICAL cores, 32 threads** (2 per core), 64 MiB L3 in two instances, 128 GB RAM — `nproc` says **32** and
that is the *thread* count. 32-way solving showed no *large* contention penalty (**12.6 cubes/min** against ~8 at sixteen workers), but per-cube times at
ONE width vary as much as any width effect (105.1 s and 129.2 s at 32-way, 126.6 s at 16-way), so **the width effect is not
distinguishable from run-to-run variation in this data**. More instances: `plans/GROKKING-INSTANCES.md` § Toolchain — Two machines.

**Keep a PREDICTED throughput beside the measured one and reconcile them whenever they disagree**: a prediction that can be
divided back out of a rate is a population check that runs itself — the answer to why writing a rule down does not install it (it caught a before/after comparison over two cube ranges
of different difficulty — the cost model failed an arithmetic check). **Say physical cores when sizing memory-hungry work**; `nproc` disagreeing with a plan is the
hardware moving — **ask which machine before treating a core or memory count as fact**, and ask to swap to the
desktop when a step wants it (the SAT solving does). Timings compare only within one machine: per-operation
ratios carry across, wall-clock totals and safe job counts do not. Measure in **CPU seconds (user + sys),
minimum of three runs**, and name the machine beside any number.

## Building

The Lean build — `./scripts/build.sh`, never `lake build`; `lake env lean`; the batch and the cap; generated modules and
invalidation — is the kernel lane's: `.claude/agents/debruijn.md` § Building Lean. What follows binds every job that runs a process.

**On any unexplained process crash, from any process: HALT and report to Kooshi immediately.** Do not
diagnose, retry, or work past it — the 2026-08-02 filesystem event (kernel ext4 oopses, ~50 compiled modules lost) is what working past one looks like.
**RAM is the discriminator; threads are not rationed** (Kooshi, 2026-09-24, replacing "one heavy job at a time", which was
conservative and easy to enforce). Every thread can and should be used, jobs pinned to disjoint cores; RAM is rationed because
exhausting it crashes the machine, against a global maximum of about 100 GB of the desktop's 125 GiB. **/tmp and swap are RAM here**
(a tmpfs and zram): every agent's scratch directory holds RAM, so large outputs (over about 1 GiB) go to disk — `data/`, or under
`~` — never to /tmp. **The enforcement is `scripts/slot.py`:** `scripts/slot.py --mem <GiB> [--cpus N] -- <cmd>` reserves RAM in a
shared ledger, admitting the job only while the reservations stay within 90 GiB and MemAvailable keeps 25 GiB free; runs it under a
hard `MemoryMax` cap with no swap, so an over-cap job is killed inside its own scope and never takes the machine; pins it to free
cores, one thread per physical core first; and exits 75, loudly, if not admitted within `--wait` (default 1800 s). `--status` shows
the ledger; `--self-test` plants an over-cap job and a full ledger and watches both refused. A job under about 2 GiB and 2 minutes
may run without a slot; anything bigger or longer declares an honest `--mem`, since an under-declared job is killed by its cap. **A
job that calls `systemd-run` itself escapes the slot's cap** (the new scope is a sibling, not a child), so a Lean build reserves and
caps at the same number: `scripts/slot.py --mem 60 --cpus 16 -- env MEMMAX=60G ./scripts/build.sh`. And `systemd-run` expands `$`
in a command's arguments unless told `--expand-environment=no` (the wrapper passes it; `bash -c '… $$ …'` arrived as `$`). More instances: `plans/GROKKING-INSTANCES.md` § Building — RAM is the discriminator.

**Every long-running phase checkpoints and resumes exactly** (Kooshi, 2026-08-26). **[PROTECTED — never compress, trim or
paraphrase this paragraph; rewrite it only to add an instance (Kooshi, 2026-09-15).]** A run expected to exceed ~15 minutes
persists its progress at natural acceptance points (a verdict, a wave, an accepted deletion, a solver's iterate) and resumes
from that state after a kill; a long phase whose state lives only in a process's memory is a **bug, not a style choice** —
on this hardware it is a bet against a demonstrated crash rate. The audit question at every phase design: *if this process
dies at any instant, what does the relaunch redo?* — and the answer is written in the subplan, beside the checkpoint's path
and the **resume command**, never discovered at the loss; a checkpoint nobody knows how to resume from is a file, not a
recovery. The instances, each a clause of the rule:
1. **The incident that minted it.** M51's iteration-3 halo shrink ran 19 hours with its state only in the parent (the cover
   checkpointed per wave; the shrink saved only on completion); one worker died, the pool's `map` hung forever, and the
   whole shrink was lost (M51 §R-INC5).
2. **The checkpoint must not live where another agent is told to clean.** `build/` is regenerable scratch, and an agent
   tidying up after itself deleted a tree under it on 2026-09-11 while a live job's only resume file sat in a sibling
   directory (`build/m63d2/ckpt-hismove/`). Recoverable state one cleanup away from unrecoverable is not recoverable:
   checkpoints live outside the scratch tree.
3. **A wall is not a checkpoint, and a tool that cannot be interrupted is not a tool for a long run** (2026-09-15, FS-50).
   Three semidefinite solves at 83 — 7.5 h, 4 h, and an implementer's 3 h 51 m — ran under `timeout` walls with the
   solver's iterate in memory only, because the solver's off-the-shelf interface neither checkpoints nor resumes; the walls
   fired or were about to, and **killing a `timeout` wrapper to lift its wall kills the child too** (GNU timeout 9.11 arms
   `PR_SET_PDEATHSIG`; tested on `sleep`), so all three were lost with nothing on disk. The rule was in this file
   the whole time; the runs were launched without asking its question. The repair: drive the solver through its own API in
   warm-started chunks, the iterate saved after every chunk and one residual line per chunk (`tools/fplane_sdp_scs.py`),
   never under a wall — and a process-model claim is tested on `sleep` before it is acted on or sent to anyone.

**A run that blocks something is presumed killable** (Kooshi, 2026-09-12). **[PROTECTED — never compress, trim or
paraphrase this paragraph; rewrite it only to add an instance (Kooshi, 2026-09-15).]** When a live job stands in the way
of anything — an edit to a module it imports, a core another task needs, a fix it would invalidate — weigh
**the value of the run against the value of what it blocks, and the default is to kill the run.** The burden
of proof is on keeping it, never on stopping it. Because every long run checkpoints (above), **the cost of
being wrong is the time to redo, never the result** — so weigh the cost of being wrong, not the hours
already spent. Three shapes met in one night, each of which looked like a reason to wait and was not:
- **The run is blocking its own replacement.** Two reductions spent hours on an operation a new engine did
  186× faster, and `tools/` could not be edited while they held it open — so "wait for them to finish" made
  the slow path self-perpetuating. Look for that circularity by name: *is the thing I am waiting on the
  thing preventing the fix?* **Second instance, 2026-09-15 (FS-50), and this rule was on this page in full when it
  happened:** four single-threaded semidefinite solves at 83, 3.4 s per iteration and a day to convergence, were kept
  running while the timing of their replacement ran niced beside them — a threaded and a GPU linear-system backend of the
  same solver, selectable the whole time by one keyword (`linear_solver=`) that had been misread the day before as
  "unavailable in this wheel" because the wrong keyword was tried — and the product owner wrote "nothing else is runnable
  until the measurements land". **Measuring the replacement is not a precondition for stopping the run**: with
  checkpoints the redo is minutes on the fast path, so the runs are killed at their next checkpoint and relaunched on
  whatever the measurement names; the two with no checkpoint on disk yet forfeited about 1,800 and 550 iterations of a
  reading the surviving run's chunk lines already gave. The shape to recognise: *the measurement I am waiting on is the
  measurement of the thing that replaces what I am protecting.*
- **The run is producing records under code you are about to fix.** Finishing banks results from the broken
  version and forces the redo anyway — and those records are the ones a later reader trusts.
- **The fix makes the redo cheaper than the run being protected.** Then waiting costs twice.

Two obligations when you do it. **Capture the run's state into the record before signalling** — a verdict
written only at `finish()` is lost, and the log is not the record. And **name what the kill forfeits, out
loud**: one such kill cost a registered out-of-sample prediction, and a forfeited instrument must not
disappear quietly merely because the decision was otherwise right.

**Kill by PID or process group, never by matching a command line.** `pkill -f <pattern>` matches the shell that runs it
and every other process whose command line mentions the pattern — including another agent's monitor. Sixth recorded
instance 2026-09-13 (FS-38 phase T): it killed the engineer's own level-7 run at 11,000 of 16,383 asks and the advisor's
watcher in the same second. `setsid` the job, write its pgid to a file, signal that. **And the pid you hold may not be
the process you mean** (2026-09-15, FS-53 A0.3): `nohup <binary> … &` followed by `$!` reports an intermediate **shell**
in this harness, not the binary — reproduced deliberately on `sleep`, where `$!` read 3469129 and the binary was its
child 3469131. Killing that pid leaves the binary running, re-parented, still writing its `--out`; the engineer found it
only because `git status` showed a **committed** artifact modified after the commit. **A kill is verified by what stopped
changing, never by the exit status of the kill**: after signalling, confirm by effect — no process of that name in `ps`,
and the file's digest identical across ten seconds. Seventh to ninth instances: `plans/GROKKING-INSTANCES.md` § Building. **The rule in one line: verify a kill against the thing you wanted stopped — the named
pid absent from `ps`, and the artifact it was writing static across ten seconds — never against group
membership, and never through a pattern that can match the killing shell.** Both checks are two commands
and both would have fired here. **A hand-rolled scan of `/proc/*/cmdline` is `pkill -f` in a
different costume** (2026-09-15, FS-53 phase B): an agent stopping one solve matched its own pattern in the command line
of the shell running the scan and killed its own process group. Nothing was lost — the certificate was already filed —
but the repair is the one to copy: find a process by the **inode of the log file it holds open**, which cannot match a
command line.

**A pipe can kill the producer, and `| tail` can hide that it did.** Same session: a mutation harness run as
`./plant.sh … | head -6` died of `SIGPIPE` when `head` closed the pipe — **before its `git checkout` restore** — leaving
a planted fault in the tree, and the verification that should have caught it was `cargo nextest run | tail -2`, whose
exit status is `tail`'s and therefore always zero. The plant reached a commit. Two rules, both already here in other
costumes: a command whose *cleanup* matters is never piped into `head`, and a gate's exit status is read from the gate,
never through a pipeline (`set -o pipefail`, or capture to a file and read it).

**Never edit a shell script while it is running.** Bash reads a script lazily, by byte offset, so a live process resumes
mid-token — it killed a 46-minute `lean4checker` run at M07 with `line 110: ull-library: command not found`, a message that
looks like corruption and is nothing of the kind. Launch long runs from a snapshot copy (`cp scripts/x.sh
build/x-snapshot.sh`; `build/` is gitignored).

## Make the gate fail, and watch it fail

**Run every check's negative control at every milestone.** Break the thing it guards on purpose, confirm it
goes red and names the culprit, then put it back. A check is not known to work until it has been seen to
fail.

Every check that has failed here failed the same way: **it reported nothing when it could not run** — a
comparison of two purchase ledgers never actually performed; an audit that aborted under `set -e` with no output
and read as a pass through a pipe; a mutation rig that re-read a stale file and scored it as a pass; negative
controls the instrument could not see. A trust receipt that fails open is worse than none, because it is
believed. So make a check's failure path louder than its success path, never let a shell pipeline swallow an
exit status the gate depends on, and give every discriminating claim a partner that goes red — a certificate
filed against the wrong problem, a vertex moved off the unit circle, a satisfiable formula handed to the checker.

**The unifying rule, from nine instruments that broke inside one phase** (M63 phase C, 2026-09-11; eight
failed by silence, one by false alarm): **every check needs a positive signal for the thing that did not
happen.** A wall that could not fire, an exception swallowed in a timer thread, a control asking the same
question twice, a pid file catching a wrapper twice, a silent forty-minute search, a control announcing a
refutation from an index mismatch, a trust receipt returning a benign verdict while checking nothing, a `grep`
that killed its own shell, a four-hour deadline armed as an exit-waiter — each quiet exactly when it had
something to report, because each reacted to an event instead of asserting an absence, and **an exit-waiter can
tell you a thing has ended, never that it is late.**

**A waiter whose success condition is a file that a GOOD outcome prevents from existing** (2026-09-12). A
sweep dumped its residual-candidate file only when the survivor list was non-empty; the count reached zero, the
file never appeared, and every waiter on it read like a hung run. Its sibling monitor had the same defect in the
other costume — a `pgrep -f` liveness check that matched its own command line, so the process-gone branch could
never fire. **Arm a waiter on a file the SUCCESS path always writes**, even if that file says "nothing found".

**And a waiter's condition must be FALSE at the moment you arm it — check that, not just the condition** (2026-09-15,
FS-53 K1). A wait-for-the-build loop watching for a line beginning `==> build:` fired **immediately**, printing
"BUILD FINISHED" at batch 140 of 172, because `scripts/build.sh` prints exactly that as its *first* output. A waiter
whose condition already holds at launch cannot tell you anything, and **it fails in the direction that looks like
success** — the implementer caught it only because the rebuilt-module count came back zero. One line before arming:
evaluate the condition and assert it is false. **Second instance, 2026-09-17, and the mechanism is different: the condition was
vacuous, not already-satisfied.** A waiter armed as `until ! pgrep -u $USER -x python3 -f "valueset.py 3"` fired in the same second,
because `-x` matches the process **name** exactly and, combined with `-f`, matched nothing at all — so "the job is gone" was true at
arming while the job had six minutes left. **A predicate that can never match reads exactly like a predicate that is satisfied**, and
both fail toward "done". The one-line guard covers both: before arming, evaluate the condition and assert it is false — here that
printed `pid=` empty, which is the tell. The repair used the PID directly (`while kill -0 <pid>`), which cannot be vacuous.
**Third instance, same session, and it is `pgrep -f` self-match wearing a waiter's costume:** `while pgrep -u $USER -f "fq_chi\.py
[23] "; do sleep 15; done` can **never** exit, because the shell running the loop carries that pattern in its own command line and
so matches itself forever. The self-match rule's eight recorded instances (§ Building; the eighth in `plans/GROKKING-INSTANCES.md`) are all *kills*; in a waiter's **condition**
the same bug fails in the opposite direction — not a wrong process killed, but a wait that never ends and looks exactly like a job
that never finished. **So the rule is not "don't pkill -f", it is "never let a pattern that can match the matching shell decide
anything"** — a kill, a wait, or a liveness check. PIDs cannot self-match; patterns always can. Arm a waiter on the live job's pid, and re-arm it whenever the job it watches is replaced (its fourth instance: `plans/GROKKING-INSTANCES.md` § Make the gate fail).

**And the rule the one above does not reach: state the uninformative outcome and confirm it is REACHABLE,
before believing a control's pass or proposing a discriminator.** "Break it and watch it go red" assumes the
break can fire. Twice in one evening it could not (M63 phase E, 2026-09-11), the same error with opposite
signs: a planted fault that could never fire (a target loosened in the direction the search ignores) and a
discriminator that could never discriminate (two attributions it could not separate). Both passed review; both
were found by opening the module. **A control whose failure mode is unreachable has not been tested by
passing** — it is indistinguishable from one that works. The paired form, measured the same evening: seven
errors between two readers, four the engineer's and three the advisor's, every one found by reading code rather
than by arguing, because each asked the right question of the other's instrument and never of their own.

**Pre-decide how you will respond to your own gate failing — before it fails, on someone else's number.**
Measured 2026-09-11: an engineer's pre-registered comparator went red on its own integration, and the honest
diagnosis was exactly the one a motivated person would reach for. It did not widen the comparator, because it
had already reasoned one commit earlier, on a different planted fault, that **a check you tune until it agrees
with you has stopped being a check** — sequencing, not virtue, and cheap: settle the policy while the number
under dispute is not yours.

**And when you replace a broad instrument with a sharp one, you lose coverage you were not measuring.** A
whole-run wall-clock test was traded for a six-point component measurement that established a cost law's
*shape* by construction — strictly better on what it measures, and blind to any cost outside the component. A
second cost of the same shape, hiding in a progress log, was invisible to the sharp instrument and would have
been caught by the weak one. **State what the old instrument saw that the new one does not, at the moment you
swap them.**

**And when you put a measured number into a decision, carry what it MEASURES, never just its value.** Three
rulings in one night rested on a number measuring something adjacent: a per-*ask solve* rate used as a
per-*candidate* cost (wrong by 30×); a contended-wall timing used as a quiet-CPU cost (1.59×); a mid-window ratio
used as a completed-window one (16× against 7×). None was a wrong measurement, which is why none looked wrong.
**A number in a ruling travels with its units, its conditions and its population, or the ruling is about
something else**; the repair is to re-derive the decision from the corrected figure out loud, because a ruling that survives its bad evidence needs new grounds, not a quiet pass.

**And the sharp, checkable form of that rule, extracted 2026-09-12 after the same error's FOURTH instance in
one milestone: when two numbers are compared, exactly ONE thing may differ between them.** A brief claimed a new
rotation gave *"twice the record's circle count and twice its unit-neighbour count"* — the doubling came from
dropping a coordinate restriction, and the unit shell does not depend on the rotation at all; a product owner
scored an off-diagonal raw count against `24/54`, a share of the monochromatic cross edges under one colouring — a
different denominator. **Both differed in two things and credited one, and the other thing was the change being
advocated, so the error flattered the work.** The check costs seconds: **write both numbers as fractions with the
denominators spelled out in words.** None of the four instances was a wrong measurement — each was a right
measurement of a different quantity, which is why none looked wrong to its author.

**The same rule has a second half, and its author broke it within two hours of writing it down.** Having
recorded *"state the uninformative outcome and confirm it is reachable"*, the product owner registered a
prediction (`P-Y1`, 2026-09-12) whose **informative** outcome was unreachable: a ratio band of 30–70% on a
quantity ~90% of which is produced in the *other* phase on byte-identical code, so a ratio near 1 was forced.
**Confirm that BOTH outcomes are reachable — the one that would teach you nothing and the one you predict.** A prediction whose target region the apparatus cannot enter is not a prediction, it is a formality that will read as a finding when it fails. And
the test of whether "mis-specified" is a diagnosis or an escape: **the evidence for the mis-specification must
predate the result** (here the 90% split was in the run's own numbers before the prediction). **The rule is
symmetric: a control going RED is not evidence either, until you can name what a wrong-reason red would look
like** — it is an unexplained failure that happens to agree with you. Three plants in one night fired for the wrong reason, one on an out-of-range index that died before
reaching the guard it was written to test. The repair is a **pair**: the stub that must fail beside a faithful
stub that must pass, so the refusal is seen to come from the cause and not the scaffolding.

**A measured half and a derived half fail in OPPOSITE directions, and one rule cannot cover both.** Where a
graph's edges are *measured* — a float proposes, exact arithmetic decides — the only possible error is a
**missed** edge, which makes colouring easier, so **a refusal is robust and a colourable verdict is suspect**.
Where edges are *derived from a law*, the error is an **invented** edge, which makes refusals faster and cheaper
and looks exactly like success — so there **a refusal is the suspect verdict.** M63 phase G, 2026-09-12: a
ruling "believe a refusal immediately" from the measured half was applied to an arena whose novelty lived in the
derived half. **Before trusting either verdict, ask which half of the object produced it**; being built by the
law is the reason the law needs checking, not the reason it does not.

**A check must read the value the code SHIPS, never a copy of it.** A control certifying the safety margin of
a float gate asserted against a hardcoded `1e-7` rather than the gate's own default, so it would have kept
certifying that margin after someone made the real default lossy — **a check reporting about code that is not
the code that runs.** It now reads the default out of the signature, and every derived quantity with it.

**And the failure path's FORMATTING is part of the check.** The same control's message rendered a failing
ratio of 0.60 as `1×` — a display rounding turning a red into something that reads like a pass. **A check's
output is the check**, and the last transformation before a human sees it is inside the trust boundary.

**Bound a plant's effect on BOTH sides, and the control reports for free when it has gone blind.** A control
that can say *"I can no longer tell"* beats one that can only pass or fail, because that third state is where this file's oldest failure mode hides — but the mechanism, not the outcome,
is what reproduces. Assert the two-sided form:

```
0 < (guarded_result − planted_result) < threshold
```

The lower bound fails when the plant has stopped firing; the upper when it fires too much. Measured 2026-09-12:
under a mutation that made the shipped value identical to the planted one, the difference collapsed to zero
and the lower bound caught it, where the one-sided `planted < guarded` would have gone silent about having
lost its power to discriminate.

**To compare POLICIES, replay them over a recorded decision sequence rather than re-running** (2026-09-12). A batch-size
lever estimated at ~2.9× measured **2.31×** when every policy was replayed over one pilot's own accept/reject log — one run,
one population, one thing differing — with the control that the replay reproduces the original run's exact cost; re-running
would have compared two populations and one policy at once. More instances: `plans/GROKKING-INSTANCES.md` § Make the gate fail.

**A cost measured on a FAILING run understates a succeeding one — and the tell is that the cheap steps are the failures**
(2026-09-12). A reduction walk was costed at **24% expensive probes** from a sample already fallen into the cheap satisfiable
regime, where each step answers in a millisecond because the object has stopped refusing; on a walk actually progressing it is
**~75%**.

> **A successful walk is the expensive walk.**

It inverts the intuition that a run going well is a run going fast, and it is how a pilot's cost model
understates the real thing by 3×. **Before costing an iterative process from a sample, check which
regime the sample's CHEAP steps were in**, because the cheap ones are the population that will not be there
when it works.

**A caveat you write and then step over is WORSE than one you never wrote** (2026-09-12). An advisor wrote *"this exhausts
the additive twist family, not the twist family"* and, in the same report, *"the 72 off-diagonal edges are measurably
load-bearing"* — the qualifier dropped, the headline amplified twice, a dead object kept alive a day. **The caveat is what
made the headline look audited**: after writing a scope qualifier, re-read the summary sentence against it.

**And the cheapest generator-image check there is: count your generator's free parameters against the
problem's.** A search ran over `{(C, π∘C)}` — one free parameter — where the solution space `{(f, g)}` has two; the image was
a measure-zero slice and the answer lived outside it, with the positive control passing. A parameter count is seconds and
catches the whole class.

**A TRUE explanation that fully accounts for the observation will stop you looking for a second one — and the second one may
be the one about your own apparatus** (2026-09-12). An engineer tested a theorem out of sample at `n = 3`, where its load-bearing
hypothesis `√(4n−1) ∉ K` fails by definition of the field (`4n−1 = 11`): the prediction was void, not met, and two laws "agreed
300 of 300" because both were inapplicable. Its first account — a mis-filed fact — was wrong in the flattering direction — a confession can flatter, because *"I filed it under the wrong heading"* is tidier and more forgivable than what actually happened: `n = 3`
fails **two** gates, and a true, sufficient-sounding reason for the first (*"this member can never reach five colours"*) made the
member look **safe to compute on** — dead as an object, free as a test case — so it never asked whether a second gate also
failed. The first failure was about the member; the second was about its own instrument.

**The habit, and it is cheap: a candidate that fails one gate must be checked against ALL of them before
being used as a test case, precisely because the first failure makes it feel already understood.** And
re-read every hypothesis against the test instance immediately before believing an out-of-sample result,
which is exactly when the result is most wanted and least examined.

**And a mutation harness must verify its own RESTORE** (2026-09-12). One broke *itself* through CPython's bytecode cache,
whose identity for a source file is `(size, mtime in whole seconds)`: a same-size mutation written inside one second left the
interpreter executing mutated bytecode against a restored source — every plant "passing" while the arithmetic under test was
wrong. What caught it was the harness **re-running its controls after the restore and asserting the guarded state comes
back**. Restore, then re-verify, and treat a same-size edit inside one second as the case your caching cannot see.

**And mutate the CONSTANT, not only the logic.** Mutating a function's *default value* rather than its *body*
is what exposed a control asserting against a hardcoded copy of that value; nothing about reading the control
would have shown it. The cheap half of the lesson, and the one that finds checks pointed at the wrong code.

**Archiving a checker can break it in exactly the way it was built to detect.** A committed equivalence harness reconstructs its
"before" tree from git and imports a module by name — so the reconstructed module binds to **today's** copy of its dependency if
that reaches `sys.modules` first, and the comparison silently becomes one tree against itself **while printing ALL MATCH**. Assert
the provenance of every module a reconstruction loads, and **provoke that assertion** — pre-load the wrong version deliberately
and confirm the harness refuses. **The sharp form: a check that loads two versions of something and identifies them BY NAME** —
module caches, class registries, singletons, environment lookups, anything with a global namespace. Its finder declined the
credit: it had been forced to reason about module identity hours earlier, on a task that loaded two copies in one process —
**an instance found by prior context is not evidence that a rule reproduces**, which is the argument *for* writing it down: it
does not reproduce from care, only from the negative control being mandatory.

**Enumerate the PARAMETER first and screen the objects against it second, never the reverse** (2026-09-12). A census of
rotations was enumerated *over a base*, so a rotation whose circle is empty over that base never became a candidate — **no row
to audit**, a family of 6-open rotations unrecorded while the headline read "none". **An omission is worse than a miscount**: a
miscount is a wrong number in a row you can check. Sibling defect: an enumerator whose cut is one-sided
on a dense set has no well-defined answer, so its `span` parameter *is* the answer — the tell is totals that never converge
while the quantity of interest does. **When a generator takes a parameter, report the quantity at two values of it before
believing either.**

**A positive control proves an instrument finds things OF THE SHAPE ITS GENERATOR CAN REPRESENT, and says
nothing about shapes it excludes.** A sweep of 781,284 candidates returned a decisive zero for a new parameter and nine hits
for the known one, its positive control passing — the known witness *was* expressible in the generator's restricted shape and
the new one was not. **Before believing any zero over a family, write down the generator's image and check the target is
inside it.**

**Do not mistake a one-sided filter for an inverted monotonicity** (an advisor's correction of the product owner who wrote it).
Once a base contains the witness, growing it cannot recover the four-colouring (more material adds colour differences, and the certificate needs a value outside them) — adding material makes a graph harder to colour
and a *sufficient condition for colourability* harder to fire: one statement, seen directly and through a one-sided filter;
nothing is inverted. An agent told to expect an inversion hunts one and misses what is unusual: the filter can be defeated by
**breaking its applicability rather than its conclusion**, and a `not-applicable` on the same footing as a silence is a pass nobody
earned. **Whenever a one-sided filter judges something you are building, enumerate the ways to make
it inapplicable before the ways to make it fail.**

**And the honest account of where these rules come from: they are scars, not foresight.** The engineer whose control
docstring already said *"a control that passes without its failure mode being reachable has not been tested by passing"* had
written a control that could not fire earlier the same evening, and noticed only when it tried to plant a fault in it. **The
habit that produces the principle is planting faults routinely, not reasoning about controls carefully.** Reasoning finds the controls you thought about; planting finds the ones you did not.
