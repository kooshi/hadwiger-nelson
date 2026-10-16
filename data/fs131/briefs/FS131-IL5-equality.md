# Brief FS131-IL5 — store `χ(F²) = L(F)` whenever `L(F) ≤ 5` as one named theorem, through the gate

*Written 2026-10-16 04:19 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IL5
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus
  role: the implementer of one short theorem the public roadmap lists as not yet stored — the main clause through five as an equality — with its audit record, its docstring, and the gate run on one commit
  launch: now, in a worktree of your own cut from `main`; beside you two kernel planners in other worktrees, which may build; none writes a file you write
  mission: § Why this job
  statements: § The statement
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage when the gate is green on one commit, and at once if the composition does not go through as stated; the report goes to `data/fs131/reports/FS131-IL5.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published). Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IL5-equality.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/il5`, on its branch `fs131-il5` (cut from `main` at `440f5cfb9`; `.lake/packages` a symlink to the main tree's, `.lake/build` a copy of the main tree's gated build): the one module you choose for the theorem (an existing module of `Rigidity/` or a new one, named in your record, with its import in `Proofs.lean` if new); `scripts/Axioms.lean` and any other gate input the new record needs, by the gate's own rules; `plans/FS131-IL5-equality.md`; your scripts and logs under `data/fs131/il5/`; `data/fs131/reports/FS131-IL5.md`. Front-file edits (`ROADMAP.md`, `LEDGER.md` row 123, `CLAUDE.md`, `README.md`) are drafted in your record, each naming its slot, not made. Commit on your branch by explicit path; never push
  budget: about 200k by the harness's count, as guidance; save a stage after the readback, after the theorem builds, and after the gate; hand back at a saved stage before about 300k

Hello. This is a short job: one theorem the public roadmap says is missing, two lines of proof, and the gate around it.

## Why this job

The repository went public this morning, and its roadmap lists, first among what the kernel does not yet store:

> 1. **`χ(F²) = L(F)` whenever `L(F) ≤ 5`, as one named theorem.** It is a two-line composition of
> — source: ROADMAP.md

A reader looking for the main clause through five as one statement finds two inequalities and an instruction to compose
them. Stored, it is the theorem a reader cites. The full gate was green on `main` this morning:

> 980. **The full gate green in the public clone, on `16a2d4499` (logged 2026-10-16 04:05 UTC; `data/fs131/clone1/run-gate.sh`, 03:51–04:04 UTC; every log under `data/fs131/clone1/gate/` with its exit on its last line; "tracked files modified after the pass: 0").** Every step exited 0: up-to-date check; `sorry` (narrow) 0 lines; 5 line-initial `axiom` lines (the three declared and the two prose lines item 943 read); doubled names and their self-test; the axiom audit — "audited: 11284 records — 10650 clean …, 569 axiom-free, 60 imported …, 5 declared purchase(s)", three declared imports — and its self-test (23 controls); vacuity "declarations=22238 refutations-skipped=240", "sites=1455 vacuous=0 stale=0 declared=3 witnessed=38 generic=1412 unknown=2", and its self-test (65 controls); assumptions "axioms=3 rests=74 named=19 inline=14 outside=7 ours=21 open=5 takes=108 mentions=2", and its self-test (33 checks); architecture PASS; the lint, 14 linters "(2/2) Passed!". The three digests: every count **matches** `CLAUDE.md` § Trust ledger and § The gate and the two ledgers' headers. **My receipt:** I printed the axioms myself from this clone's build (`lake env lean` under the slot): `SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five` and `Rigidity.min_localBound_five_le_chromaticNumber` on the standard three, `Rigidity.positive_entropy_rigidity` and `StandingFive.kloosterman_bound`; `Outside.OAI158.chromaticNumber_plane_six_or_seven` on the standard three and `Outside.OAI158.no_proper_five_coloring`; `Outside.OAI158.chromaticNumber_plane_eq_chiM0` and `Plane.oneAvoidingDensityBound` on the standard three — as the front page states. Not run: `lean4checker` (the publication gate, owed before a write-up) and the regeneration check. The publication guard over the twenty logs: 0 refusals.
> — source: plans/FS131-close-inventory.md

## The statement

The two theorems it composes, as the library states them:

> theorem min_localBound_five_le_chromaticNumber (F : Subfield ℝ) [NumberField F] :
>     min (localBound F) 5 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber :=
> — source: Proofs/HadwigerNelson/Rigidity/ChainHeadline.lean

> theorem chromaticNumber_planeOver_le_localBound :
>     ((unitDistance ℂ).induce (planeOver F)).chromaticNumber ≤ localBound F :=
> — source: Proofs/HadwigerNelson/Arith/UpperHalf.lean

The target: for every real number field `F` (`F : Subfield ℝ` with `[NumberField F]`), `localBound F ≤ 5` implies
`((unitDistance ℂ).induce (planeOver F)).chromaticNumber = localBound F`. A conditional version already exists over the
chain's named hypotheses (`UpperHalf.chromaticNumber_eq_localBound_of_chain`, `Proofs/HadwigerNelson/Arith/UpperHalf.lean` l. 300); the new one
takes none of them.

## Done means

1. **Stage 1 — the readback.** Check the quotations against their sources; restate the target in your record.
2. **Stage 2 — the theorem**, with a docstring that says what it states in words, what it rests on (the declared
   outside theorems it inherits), and whose each half is (the upper half prior art, as `LEDGER.md` row 52 says; the
   lower half this project's derivation, "prior art: not found in print" at ℚ(√47), as row 121 says), built through
   `./scripts/build.sh` under the slot; `#print axioms` on it, recorded.
3. **Stage 3 — the gate on one commit**: the steps of `data/fs131/clone1/run-gate.sh` (the run that passed this morning;
   copy it under `data/fs131/il5/` and point its log folder there), the audit's coverage taking the new record by the
   gate's own rules, and the counts' changes explained one by one against this morning's (`data/fs131/clone1/gate/`).
   Read the statement aloud against `ROADMAP.md`'s item 1 in your record.
4. **Stage 4 — the drafts**: `ROADMAP.md` item 1, `LEDGER.md` row 123's "Not claimed" line, `README.md` if it lists the
   statement as missing, and `CLAUDE.md` § The gate and § Trust ledger counts — each draft naming its slot.
5. **The report**, in the standing rules' form.

## What is yours to decide

The theorem's name and module (a name that reads as the statement, in the library's style), and how the gate's inputs
take the new record. If a stronger statement is as short — for instance the equality at every field where the lower
bound reaches `L(F)` — say so with its form, and store the brief's target unless it is strictly implied.

## The machine

This is the laptop: 12 cores, 31 GB, shared with two planners that build. From inside your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 10 --cpus 4 -- env MEMMAX=10G BATCH=4 ./scripts/build.sh`;
the gate's steps each take up to 8 GiB under the slot. On exit 75 wait ten minutes and retry. Never `lake build`. `/tmp`
is a tmpfs: keep what your record cites under `data/fs131/il5/`.
