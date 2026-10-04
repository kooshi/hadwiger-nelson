# Brief FS131-I1 — wave 1 of the Lean backlog: replace the 28 `sorry` leaves on branch `fs131-w1`, run the gate, land the wave

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow
  role: build wave 1's kernel modules from the planner's skeleton and per-leaf plans, through the full gate, and land the wave on `main`
  launch: now; the planner (FS131-K1) has handed back, so no other Lean job is running
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I1.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I1-implementation.md`
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w1` (branch `fs131-w1`): the seven wave-1 modules (`Proofs/HadwigerNelson/Plane/Chord.lean`, `Proofs/HadwigerNelson/Plane/Closure.lean`, `Proofs/HadwigerNelson/Plane/DensityPoints.lean`, `Proofs/HadwigerNelson/Plane/Diameter.lean`, `Proofs/HadwigerNelson/Plane/UnitAvoiding.lean`, `Proofs/HadwigerNelson/Arith/FalconerFan.lean`, `Proofs/HadwigerNelson/Arith/NoAffine.lean`), supporting lemmas in the foundation modules under `Proofs/HadwigerNelson/Plane/`, `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `plans/FS131-I1-implementation.md`, `tools/fs131_i1_*.py`, `data/fs131/i1/`, `data/fs131/reports/FS131-I1.md`; and, at the landing only, `main` by fast-forward
  budget: about 350k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are building the first wave of the milestone that turns this project's hand-derived results into kernel-checked ones. Since
Workflow 3.1 a milestone closes only when its Lean module passes the gate; the milestones closed before then left about 200 results proved
on paper only, and this milestone formalizes them, wave by wave. Wave 1 is fourteen of them: facts about sets in the plane that avoid
distance 1 (diameters, closures, chords, density points) and three statements about Falconer fans and affine colourings. Nearly every later
wave stands on these, so a leaf proved cleanly here is used many times.

## Why this job

The planner, de Bruijn on Opus (job FS131-K1), wrote the skeleton — every statement in Lean with `sorry` at each leaf — and a plan for each leaf,
and read every formal statement back against its source. Your work is what makes these results "held": the milestone's announcement rule
(`plans/FS131-close-inventory.md` § The announcement rule) counts a result as kernel-checked only when its declaration passes the full gate and
its axioms are read from the gate's saved log.

## The statements

The statements are the 28 `sorry`-ed declarations on branch `fs131-w1` (head `3358a401`), in the seven modules named under `touches`. Each is
read back against its backlog row in `plans/FS131-kernel-plan.md` § 6.2, and each leaf's plan is § 6.3. The rule that governs them:

> **The implementer may**: add lemmas (children) anywhere in the wave's modules, add supporting lemmas to the foundation modules
> — source: plans/FS131-kernel-plan.md § 6.1 Where it is, and how the implementer works

(the paragraph continues there, and ends: "**It may not** change any statement below; a needed change comes back through Keryx.") Read § 6.1 in
full first: it holds the worktree recipe, the build command, and how the wave lands. Four statements are deliberately stronger than their
backlog rows (the planner's generalizations G1–G4, listed in § 6.2 and in the inventory, item 12); prove them as stated.

## Done means

1. Every one of the 28 leaves proved, no statement changed, no new `axiom`, no `native_decide`.
2. **The full gate green on one commit in the worktree** (`LEAN.md` § The gate; § 6.1's list): the build with zero warnings; `scripts/axioms.sh`
   clean, with the 28 new records on the standard three axioms or fewer; `scripts/vacuity.sh` and `scripts/vacuity.sh --self-test` green;
   `tools/check_architecture.py` exit 0; each check's negative control watched going red (`RUNNING.md` § Make the gate fail, and watch it fail).
   Read the saved logs under the worktree's `build/gate/`, not the line that says a gate passed.
3. **The landing** (§ 6.1): merge `main` into `fs131-w1`, resolving the append-only lines of `ARCHITECTURE.md`, `Proofs.lean` and
   `scripts/Axioms.lean`; re-run the gate; then fast-forward `main` to the branch and push. If `main` has moved again by then, merge once more and
   re-run; never force-push.
4. **Your record**, `plans/FS131-I1-implementation.md` on the branch, in stages headed "Stage n — SAVED", with "Theorems this phase proved": one
   line per kernel theorem — its declaration, its axioms (from the saved audit log), and the backlog row it was read against.
5. **Drafts for the front page**, in your record under `## Drafts for the front page`, each naming its slot: the gate's new counts for `CLAUDE.md`
   § The gate and § Trust ledger, and for `scripts/vacuity-baseline.txt`'s header (the counts now recorded there were filed at the foundation's gate,
   `0622bdd9`). Ledger rows are regraded at the milestone's filings, not per wave: list which ledger rows (if any) wave 1's declarations bear on, and
   draft nothing for `LEDGER.md` yet.
6. The report, in standing rule 11's form.

## What is yours to decide

The proofs, the children you introduce, the order of the leaves, and where a supporting lemma lives. A leaf priced from the plan may turn out
cheaper or dearer; re-price from your first two leaves (`LEAN.md` § The kernel's cost model) and say so in your record. If a leaf cannot be proved
as written — it looks false, a hypothesis seems missing, a definition seems wrong — stop that leaf, message me at once with the declaration, the
reason, and the smallest counterexample or the missing hypothesis, and go on with the others; the planner and the deriver decide, never the
implementer. If a route in the plan fails three times, invoke the companion your identity names for that failure rather than trying a fourth.
Stopping at a saved stage with leaves left, and saying which, is a good report.

## Stages

1. **The readback**: check the quotation above against its source; restate in your record what you may and may not change, and where the wave
   lands. Confirm the worktree's build is current (one `./scripts/build.sh` run under the slot, per § 6.1). Commit on the branch, push the branch.
2. **The leaves**, one module at a time, committing and pushing after each module is sorry-free.
3. **The gate**, in full, with the negative controls. Commit.
4. **The landing** and the drafts. Commit, then report.

## The machine

Build only from inside the worktree, with the command § 6.1 gives
(`/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`); never `lake build`. `lake env
lean <file>` is for iteration only — it does not apply the lakefile's options, so it is never evidence that a module is green. One Lean build at a
time across all trees on this machine. The worktree's `.lake/packages` is a symlink to the main tree's and its `.lake/build` is its own copy; never
replace that copy with a symlink, because two trees compiling into one build race on the same compiled files.
