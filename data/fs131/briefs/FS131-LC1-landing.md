# Brief FS131-LC1 — land one finished module through the full gate: the chromatic number of the plane equals its Lebesgue-measurable chromatic number

*Written 2026-10-13 17:35 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of today. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-LC1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the lander of one finished module — it has no `sorry` and builds in its tree; you take it through every step of the gate on one commit, make three docstring corrections its planner drafted, register its records, read its headlines aloud against the claim list and the printed page, and draft the front-page lines; the fast-forward of `main` is the coordinator's, at your green line
  launch: now, in the tree the module was written in — its planner has handed back and nobody else writes there; three planners work in other trees (`fs131-wnf`, `fs131-wch`, `fs131-wr2`) and may hold the build slot: you will wait for it at times
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage **at once** if a gate step fails in a way the module's record does not explain, if the read-aloud finds a statement that says more or less than its claim or its page, or if a step needs more memory than this machine's cap; **with one line when the gate is green on one commit** (then stop: the fast-forward of `main` is mine); the report goes to `data/fs131/reports/FS131-LC1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-LC1-landing.md` (new, on branch `fs131-wkc`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wkc` (branch `fs131-wkc`, at `7b9070f48`; its `.lake/build` is current for that commit — the planner's build was green an hour ago): `Proofs/HadwigerNelson/Plane/LebesgueNumber.lean` (docstrings and registrations only: **no statement of it changes**); the docstrings of three existing declarations named below (no statement changes); `scripts/Axioms.lean`, `scripts/Assumptions.lean`, `scripts/assumptions-ledger.txt`, `scripts/vacuity-baseline.txt` as the gate's steps require; `ARCHITECTURE.md` if a row needs a word; `plans/FS131-LC1-landing.md`; `data/fs131/lc1/`; `data/fs131/reports/FS131-LC1.md`. Nothing on `main`; no push
  budget: about 350k by the harness's count, as guidance; you cannot read that count, so save a stage (a commit on your branch) after the readback, after the registrations, after each gate step that passes, and at the green line; hand back at a saved stage if a step will not pass after two tries, saying which and what you would try next

Hello. A planner of this lane was asked this afternoon for a skeleton and came back with a finished module: every
leaf fell while it was typing. Your job is the part it did not do — the gate — on a machine this gate has never run
on.

## Why this job

The project is being wound down and published. Kooshi's rule for what goes out, and his word on this result:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

> W3: (2026-10-13, after the report on the new paper and the corollary a reader drew from it) which new paper is that? sorry, […] I won't be able to keep up with the minutia. It sounds like a great candidate to formalize too.
> — source: data/fs131/REQUEST-2026-10-13.md

The result: the chromatic number of the plane equals its measurable chromatic number, with colour classes Lebesgue
measurable and no two points at distance one sharing a colour. The library already proved the same with "proper at
almost every unit pair", on one declared outside theorem; the step to "every unit pair" was listed as a gap. A paper
posted on 8 October prints that step as a short appendix lemma, and the module formalizes the lemma with its printed
proof and composes the two. Anyone holding both papers can draw the same corollary, which is why it is landed first
and alone. **The mathematics is other people's**: the docstrings already say so, and every line you draft for the
front page says so — a printed lemma, formalized here; a declared outside theorem; a composition.

Until it is through the gate it is not "held", and the report to Kooshi waits on your green line.

## The statements

The claim list, fixed before the module was planned, with the dated line that corrected it:

> NF3-PRINTED: **Lemma B.1** (p. 44). "Suppose that A₁, …, A_k ⊆ ℝ^d are measurable D-avoiding sets whose union is conull. Then ℝ^d admits a measurable proper k-colouring of its D-distance graph." (Appendix B's standing hypotheses, p. 44: "Throughout, D = {d₁, …, d_t} ⊆ (0, ∞) is finite and nonempty, d ⩾ 2, and k ⩾ 2." Before the lemma: "We first show that a measurable proper colouring of a conull set can, after changes on a null set, be extended to a measurable proper colouring of ℝ^d. We suspect that this is a folklore result, but have not found it in the literature.")
> — source: data/fs131/claims-NF3.md § Statements

> NF3-WEAK-TO-PROPER: **ER1-WEAK-TO-PROPER** — a weak measurable `k`-colouring of `ℝ^d` (Lebesgue measurable, proper at almost every pair at a distance in a finite `D`) gives a Lebesgue-measurable `k`-colouring proper at every such pair; so `χ_m⁰(ℝ²) = χ_m(ℝ²)`. **[hand]**, one mind, over `[Davies2026]` Lemma B.1 as printed (p. 44; its proof checked here) and the density-point step printed in `[DeCorteOliveiraVallentin2022]` (proof of Lemma 5.6). § M.
> — source: data/fs131/claims-NF3.md § Statements

> NF3-PLANE: **ER1-PLANE-FALCONER** — `χ(ℝ²) = χ_m(ℝ²)`, Falconer's number. **[derived]** from ER1-WEAK-TO-PROPER and the declared outside theorem `Outside.OAI158.proper_to_borel_weak`; one mind; in neither paper as far as each was read. § M.
> — source: data/fs131/claims-NF3.md § Statements

> NF3-NC: that either statement is this project's theorem (each is a composition of two outside results); any value of the plane's chromatic number; anything about Borel classes where the statements say Lebesgue; anything in dimension other than two or for distance sets other than the unit distance beyond what a planner finds comes free; that the printed lemma is new (its paper says it suspects the lemma is folklore).
> — source: data/fs131/claims-NF3.md § Not claimed

> - 2026-10-13 16:51 UTC — **The library's `Plane.chiM` is the Borel number, not the paper's Lebesgue one; found by the module's planner (FS131-KC1) at its readback.** Its words: "`Plane.chiM` (`Plane/FalconerReduction.lean:27–28`) asks `∃ f : ℂ → Fin k, Measurable f ∧ ∀ x y, dist x y = 1 → f x ≠ f y`. `Measurable` on `ℂ` is Borel … The paper, p. 2: 'Requiring the colour classes to be Lebesgue measurable gives the measurable chromatic number'. Lemma B.1's output is Lebesgue only … So `chiM0 = Plane.chiM` and `χ(ℝ²) = Plane.chiM` are not what the lemma gives". **NF3-WEAK-TO-PROPER and NF3-PLANE are therefore typed over a new definition of the Lebesgue number** (the least k with a map `ℂ → Fin k` that is null-measurable for Lebesgue measure and proper at every unit pair), with the inequality "Lebesgue number ≤ `Plane.chiM`" beside them; `Plane.chiM` is untouched. **The claim list's header line naming `Plane.chiM` as the object is superseded by this line.** The core lemma is typed in the general form the planner found comes free (every translation-invariant graph on a finite-dimensional real normed space with a Haar measure, any set of distances), the plane and the unit distance as its instance.
> — source: data/fs131/claims-NF3.md § Dated lines

Where everything is: the module `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wkc/Proofs/HadwigerNelson/Plane/LebesgueNumber.lean`;
its planner's record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wkc/plans/FS131-KC1-measurable-number-plan.md` and
report `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wkc/data/fs131/reports/FS131-KC1.md` (the report holds seven
drafts in full: three docstrings, the ledger row's clause, the reader's sentence, three facts for `LEAN.md`, the
trust addition); the paper `/home/kooshi/source/library/pdf/Davies2026-measurable-obstructions-unmeasurable-colourings.pdf` (the lemma is on its p. 44, the definition of the measurable number on its p. 2);
the last landing's record `plans/FS124-L2-landing.md` and receipts `data/fs124/l2/gate/` — **its stages are the
pattern for yours, and its three final receipts are the "previous" side of your digests**.

## Done means

1. **Readback** (a saved stage): the six quoted lines checked against their sources; the planner's record and report
   read; `LEAN.md` § The gate, § Assumptions and § Trust ledger as they stand; the last landing's record, stages 3 to
   9. Merge `main` into the branch (it has moved in `plans/` and `data/` only — say so with the diff that shows it).
2. **Three docstring corrections, from the planner's drafts, verbatim**: `Plane.chiM` (it is the Borel number, not
   Falconer's), `Plane.le_chiM_of_falconerFan` (its bound is on the Borel number), `Plane.AeColouring` with
   `Plane.chiM0` (they ask a Borel map; the number is the same, now proved both ways). **No statement changes.** They
   rebuild what depends on those files: build once, under the slot, and record the wall time and peak memory — that
   is this machine's first measurement of a build that recompiles real modules.
3. **The registrations**: the module's records as one block of yours in the audit script — the planner counts eleven
   on the standard three or fewer and three resting on the declared outside theorem `proper_to_borel_weak`; file
   every declaration a person typed, as the last landings did, each under the banner its axioms put it under;
   `tools/check_architecture.py` exit 0; the doubled-name check.
4. **What the library assumes**: `./scripts/assumptions.sh --self-test`, then the step. Three theorems rest on the
   declared outside theorem, so the ledger gains rows: list each, write the ledger with the script's own flag, and
   say which of the nine counts move and to what.
5. **The vacuity step** and its `--self-test`: how the scan classes every new site; and name by hand the kernel model
   of each hypothesis of the headlines (the planner names two colourings the module runs its lemmas on).
6. **Read aloud**, in your record: each headline theorem against its claim line and the dated line; **the lemma
   against the paper's page, clause by clause, with its standing hypotheses**; the new definition of the Lebesgue
   number against the paper's own definition on its p. 2 — which measurability, which pairs. A difference is a
   message to me before the gate runs.
7. **The full gate on one commit**: `./scripts/build.sh` with zero warnings; zero `sorry` in `Proofs/` (a search whose
   plant fires); the doubled-name check and its `--self-test`; `scripts/axioms.sh` clean with `--self-test` green;
   `scripts/vacuity.sh` and `--self-test` green, counts reconciled; `./scripts/assumptions.sh` and `--self-test`
   green; `tools/check_architecture.py` exit 0; the guarded lint (`lake lint --no-build -- --no-build --trace`, under
   the slot), silent; the notes check and the records check as the last landing ran them. The three digests against
   `data/fs124/l2/gate/receipt-axioms-final.log`, `data/fs124/l2/gate/receipt-vacuity-final.log` and
   `data/fs124/l2/gate/receipt-assumptions-final.log` (they will report the front page stale until your drafts are
   filed: say exactly which lines). Every step's log saved under `data/fs131/lc1/gate/` and named, **with each step's
   wall time and peak memory on this machine**. Then one line to me, and stop.
8. **Drafts for the filing**, in your record under "Drafts for the front page (FS131-LC1)", each with the log line it
   comes from and the exact words on `main` it replaces or follows, each slot checked by a script to occur once (the
   last landing's `data/fs124/l2/drafts-slots.py` is the pattern): the audit's and the gate's count lines in
   `CLAUDE.md`; the trust ledger's sentence on the declared outside theorem's records; a `GATE_CHANGES` entry; the
   ledger row's "not claimed" clause and closing clause and the front page's sentence on Falconer's number (the
   planner's drafts, checked against what landed); `LEAN.md`'s facts; the bibliography's read-status line; the
   reader's sentence. And the open gate items at this landing, by name.
9. **Your record**, stages headed "Stage n — SAVED (FS131-LC1)"; the report in the standing rules' form, the counts
   read from the gate's saved logs. Leave no background process running. Stopping at a saved stage with the gate red
   at a named check is a good report — say which check, its log, and what you would try next.

## What is yours to decide

The order of the gate's steps before the final pass; how the records are grouped in the audit block; the batch size
of each build (see below); the wording of an open gate item. If the read-aloud shows a docstring of the new module
claiming more than its theorem, fix the docstring and say so.

Not yours: any statement; the fast-forward of `main`; a push; anything in another tree.

## The machine

**This session is on the laptop: 12 cores, 31 GB — the desktop's numbers in `RUNNING.md`, `LEAN.md` and the last
landing's record do not apply.** Measured today: one file through `lake env lean` costs 3 to 24 seconds and 3.6 GB; a
build in which only small new modules are stale is a 24-minute walk at `BATCH=2` (Lake is started once per batch, 947
times) with 3.7 to 4.5 GB at its peak. **Nothing else of the gate has been measured here**: the audit, the two scans
and the lint each elaborate a large file, and their memory on this machine is unknown. Run the memory tool as

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --name lc1 -- <command>`

One file: `--mem 4 --cpus 2`. A build: `--mem 10 --cpus 8 -- env MEMMAX=10G BATCH=2 ./scripts/build.sh`; a wider batch
is yours to try once you have seen what the first build's largest step used. A gate step that elaborates the whole
library: start at `--mem 14`, and if it is killed for memory tell me what it reached before you raise it — 18 is the
most this machine can give while others iterate. Three planners share the slot: on exit 75 wait and retry. Never
`lake build`. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at power-off: every log
your record cites lives under `data/fs131/lc1/`.

The remote is unreachable: **commit by explicit path on your branch and do not push**.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## Amendment 1 (2026-10-13 18:00 UTC) — your read-aloud's difference is recorded, and your four decisions stand

The difference you found (the claim's clause for every dimension and a finite set of distances against a kernel
theorem for the plane and the unit distance) is now a dated line in `data/fs131/claims-NF3.md`: your drafts regrade
the plane clause and the equality, and nothing wider. Your four decisions stand as you stated them: the four further
docstring lines of the same slip corrected in the same build; the five docstring fixes in the new module; the two
state-reading counts in `scripts/axioms-controls.txt` moved by that file's own rule after the self-test is seen red on
them; thirty-four records filed, and the two architecture rows and the trust row corrected. **Your touches are
extended to `scripts/axioms-controls.txt` and to the docstrings and module headers of
`Proofs/HadwigerNelson/Plane/FalconerReduction.lean` and `Proofs/HadwigerNelson/Plane/AeColouring.lean`** — docstrings
only, no statement, with the kernel-side comparison after the build as you planned. Your note that the number is
defined over the complex plane while one headline has the Euclidean plane on its left goes into the open gate items.
You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only
review work it knows exists).
