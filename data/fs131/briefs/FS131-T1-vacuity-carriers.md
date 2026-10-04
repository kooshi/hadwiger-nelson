# Brief FS131-T1 — the vacuity check: track the backlog's new carrier types, before wave 2 lands

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-T1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; this is a project-tooling job (its § Project tooling)
  role: extend `scripts/Vacuity.lean` so that theorems over the Lean backlog's new structures are checked for empty domains, with a planted control for each, and leave `main`'s gate green with its counts reconciled
  launch: now, beside FS131-K2b and FS131-K3b (two planners, each in its own worktree); you work in the main tree
  mission: § Why this job
  statements: § The defect
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job only for a question you cannot work around; the report goes to `data/fs131/reports/FS131-T1.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full (§ The gate above all), and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-T1-vacuity.md`
  touches: `scripts/Vacuity.lean`, `scripts/vacuity-controls.lean`, `scripts/vacuity.sh` (only if the fix needs it), `plans/FS131-T1-vacuity.md`, `data/fs131/t1/`, `data/fs131/reports/FS131-T1.md`
  budget: about 200k by the harness's count, as guidance; hand back at a saved stage before about 350k

Hello. The vacuity scan is the gate's check that no theorem is a "for all" over an empty domain — the characteristic way a formalization proves the
wrong theorem efficiently (`LEAN.md` § The gate). It tracks a named list of carrier types (`trackedProps` in `scripts/Vacuity.lean`, with its
docstring's reasons for what is in and out). The Lean backlog (milestone FS-131) has started adding new structures that theorems take as hypotheses,
and the list does not know them yet.

## Why this job

Wave 1 of the backlog landed on `main` today (`d59ffcdf`). Its implementer found that the scan is blind to the first of the new types, and wave 2 —
planned now, landing soon — states many theorems over it and its relatives. A gate that silently passes those is the failure this gate exists to
prevent, so the fix lands before wave 2 does.

## The defect

As FS131-I1 reported it:

> - tool defect — scripts/vacuity.sh does not treat AeColouring k as a tracked carrier: a planted `theorem (c : AeColouring 1) (x : ℂ) : x = x` raised no site and no VACUOUS row (declarations 7624 → 7625, sites unchanged) though IsEmpty (AeColouring 1) is in the evidence; wave 2's AeColouring/partial-colouring statements will have no vacuity check until Vacuity.lean learns the carrier; no wave-1 statement affected (all at variable k) — scripts/Vacuity.lean (outside my touches), build/i1-vac-plant.log
> — source: data/fs131/reports/FS131-I1.md

(its evidence log is `.claude/worktrees/fs131-w1/build/i1-vac-plant.log`, in wave 1's worktree.)

## Done means

1. **The defect reproduced first**, on `main`, with the planted theorem, and the null result logged in your record.
2. **The new structures surveyed**: every structure the backlog's foundation on `main` defines that a theorem may take as a hypothesis
   (`Proofs/HadwigerNelson/Plane/` — `AeColouring` at least; `ArcMap` and its validity and class predicates, and anything else there), each decided in
   or out of the tracked list with its reason in the docstring, in the style of the existing entries (`UDCert`'s exclusion is the model of an
   argued "out").
3. **The fix**: the scan tracks the "in" structures; `AeColouring 1` planted reads VACUOUS (or STALE, whichever the law gives for a proved emptiness
   that is not declared — say which and why), a theorem over `AeColouring k` at a variable `k` reads GENERIC.
4. **Self-test controls** added to `scripts/vacuity-controls.lean` for the new carriers — at least the empty `AeColouring 1` and the generic
   `AeColouring k` — and `./scripts/vacuity.sh --self-test` green with every control firing, the old seven included.
5. **How a later wave registers its carriers** written in the docstring beside the list (wave 2 brings `AeCover`, maximal covers and partial
   colourings on its own branch; its implementer will add them by that note).
6. **`main`'s gate green with the counts reconciled**: `./scripts/build.sh` first (the main tree's build has not compiled wave 1's modules — they
   were built in the worktree), then `./scripts/vacuity.sh`; every change in sites and verdicts explained line by line, and any new UNKNOWN (a concrete
   carrier with no proved inhabitant) named. Drafts of the new counts for `CLAUDE.md` § The gate and `scripts/vacuity-baseline.txt`'s header in your
   record under `## Drafts for the front page` — I file them; you do not edit either file. If a new UNKNOWN would have to enter the baseline, stop and
   message me instead: the baseline only shrinks.
7. Your record, with "Theorems this phase proved" (none — a tooling job), and the report in standing rule 11's form.

## What is yours to decide

The shape of the fix in `scripts/Vacuity.lean`, and each structure's in-or-out call with its reason. If tracking a structure would drown the signal,
as `UDCert` would, say so and leave it out with the reason written down.

## The machine

Builds through `./scripts/build.sh` under the slot (`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`), never `lake
build`; up to two builds may run at once across trees when the slot admits them (inventory ruling 5). Commit by explicit path on `main` and push: your
files are tooling, and `main`'s gate must read green after each commit that touches them.
