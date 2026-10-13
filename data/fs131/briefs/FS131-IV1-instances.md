# Brief FS131-IV1 — the last three leaves of the first number-field module: join its two proved files and prove the instances that give its theorems something to be about

*Written 2026-10-13 18:56 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of today. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IV1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the implementer who finishes one module — merge the branch that holds its second proved file into the branch that holds its first, prove the three leaves of its instances file, build once, and print the axioms of every public theorem of the three files, so that a landing can follow
  launch: now, in the tree of the module's first file — its implementer has handed back and nobody else writes there; a landing of another module is in flight in the tree `fs131-wkc` and a planner works in `fs131-wr2`: the build slot is shared
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if the merge conflicts under `Proofs/`, if a leaf is false as stated or needs a hypothesis it lacks, and with one line when the three files have no `sorry` and the instances print their axioms; the report goes to `data/fs131/reports/FS131-IV1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IV1-implementation.md` (new, on branch `fs131-wnf`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf` (branch `fs131-wnf`, at `41e5e379e`; its build is current for that commit): the merge of branch `fs131-wq1` (at `0cc28eb08`); `Proofs/HadwigerNelson/Instances/UpperHalfValues.lean` — proofs and private helpers only, **no statement changes**; `ARCHITECTURE.md`'s three rows of this module where they still say "a skeleton"; `plans/FS131-IV1-implementation.md`; `data/fs131/iv1/`; `data/fs131/reports/FS131-IV1.md`. Nothing on `main`; no push
  budget: about 250k by the harness's count, as guidance; save a stage (a commit) after the merge, after each leaf, and after the build; hand back at a saved stage with what is left by name if a leaf resists two honest routes

Hello. Two implementers finished the two main files of this module today, on two branches; every leaf proved, no
statement changed, each built in its own tree. Three leaves are left, in the instances file, and they matter more
than their size.

## Why this job

Kooshi's rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

The module says a plane over a real number field needs no more colours than its residue targets, and closes exact
values with it. Two of its theorems — two colours at a stable prime modulo which conjugation is the identity — have a
hypothesis that nothing in the kernel yet satisfies: the one model is the rational field with its prime above 2, and
that is one of your three leaves. A theorem whose hypothesis has no inhabitant cannot go through this library's gate,
so the module cannot land until these are proved. With them, four values become theorems on the standard three
axioms: the plane over the field of the square root of 11 needs exactly four colours; the rational plane exactly two;
two upper bounds as controls.

## The statements

The module's claim and what it closes, from the claim list fixed before it was planned:

> NF1-MODULE: **The first module I would start with, whatever the ranking:** the residue upper half — `[S1a]` and `[S1b]` in one new module (`Arith/UpperHalf`, importing `Arith/PlaceHom` and `SpectralChain`), `[S2]` for real quadratic fields in a second (`Arith/QuadraticPrime`), and the values they close in a third (`Instances/…`: `χ(ℚ(√11)²) = 4`, `χ(ℚ²) = 2`, `χ(ℚ(√167)²) ≤ 8`, `χ(ℚ(√47)²) ≤ 5` again as the control against `SqrtFortySeven`). Reasons: thirteen rows wait on it; it discharges one hypothesis of the headline (`inline:UpperHalf`) and is leaf 1 of row 99; it imports nothing; and the result everyone expects first, `χ(ℚ(√47)²) = 5`, is not reachable without the whole chain, of which this is also a leaf. Two implementers could run at once with no shared file: one on `Arith/UpperHalf`, one on `Arith/QuadraticPrime`; the instances file follows both. In parallel and independent of both, the chain's own first leaf is C0 (naming `T + A`) and then leaf 13 (entropy): a third tree.
> — source: data/fs131/claims-NF1.md § Statements

> NF1-NC: any lower bound for a plane over a field; anything above level one of a tower; `[S2]` at a prime where some radicand is not a square; that an instance's value is new mathematics (the value four over the field of the square roots of 3 and 11 is K. G. Fischer's of 1994; `LEDGER.md` § The claim list says what is ours); that the upper half alone gives any exact value — each exact value named also needs its lower half, which the map says the kernel holds for the instances listed.
> — source: data/fs131/claims-NF1.md § Not claimed

**Your three leaves, by name**, in `Proofs/HadwigerNelson/Instances/UpperHalfValues.lean`: `numberField_bot`,
`two_le_chromaticNumber_planeOver`, `exists_stablePrime_rat`. Their statements are the file's; read them in the
source. **The plan per leaf**: `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf/plans/FS131-KN2-upper-half-plan.md` § Stage 4 (the instances' part) and § D (the split and what the landing
needs). The two implementers' records — `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf/plans/FS131-IU1-implementation.md`
and `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/plans/FS131-IQ1-implementation.md` — each end with what
they learned that the plan does not say, and with drafts for the landing.

## Done means

1. **The merge** (a saved stage): trial it first and name any conflict; I trialled it an hour ago and it was clean
   (the two branches differ in one file each under `Proofs/`). Then the readback: each leaf's statement restated in
   one line with the plan's route.
2. **The three leaves**, without changing a statement; then no `sorry` in any of the module's three files.
3. **No statement changed**, shown from the kernel's side for the instances file (either implementer's comparison
   script is the pattern; a planted fault watched firing).
4. **One build**, under the slot, zero warnings from the three files.
5. **The axioms of every public theorem of the three files**, printed from the built modules: the standard three and
   nothing else. And for each hypothesis-shaped headline, the theorem or example that inhabits it, named — the
   two-colour theorems' above all.
6. **The three rows of `ARCHITECTURE.md`** brought to what is true; `tools/check_architecture.py` exit 0.
7. **Drafts for the landing**, gathered in one place in your record from the two implementers' drafts and your
   own: the audit block for the three files (every declaration a person typed), the model table, and the note the
   planner left for the assumptions step — a named hypothesis this module now proves has to leave the ledger, and
   the nine counts move.
8. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; private helpers; whether a leaf is one line from something the two proved files now hold. Not yours:
any statement; new instances (two further values the ledger names are a planner's to state); the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB.** Measured today on this module: one file through `lake env lean`
costs 3 to 6 seconds and 3.6 GB; a build is 7 to 9 minutes at `BATCH=8` when only this module is stale, 4.5 GB at its
peak. Write against `lake env lean` and build once; do not edit a module file while a build walks.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name iv1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree. The
build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never `lake build`. A landing's gate steps
have priority on the slot. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at
power-off: anything your record cites lives under `data/fs131/iv1/`.

The remote is unreachable: **commit by explicit path on your branch and do not push**.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
