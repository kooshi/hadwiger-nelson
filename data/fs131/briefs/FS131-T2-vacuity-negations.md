# Brief FS131-T2 — the vacuity check: a theorem concluding `≠` or `¬` is not a refutation

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-T2
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; this is a project-tooling job (its § Project tooling)
  role: make `scripts/Vacuity.lean` skip only declarations whose stated conclusion is `False`, so that a theorem concluding `≠` or `¬` over an empty carrier is audited like any other, with planted controls, and leave `main`'s gate green with its counts reconciled
  launch: now, beside FS131-K2b and FS131-K3b (two planners, each in its own worktree); you work in the main tree
  mission: § Why this job
  statements: § The defect
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job only for a question you cannot work around; the report goes to `data/fs131/reports/FS131-T2.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full (§ The gate above all), and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-T2-vacuity.md`
  touches: `scripts/Vacuity.lean`, `scripts/vacuity-controls.lean`, `scripts/vacuity.sh` (only if the fix needs it), `plans/FS131-T2-vacuity.md`, `data/fs131/t2/`, `data/fs131/reports/FS131-T2.md`
  budget: about 200k by the harness's count, as guidance; hand back at a saved stage before about 350k

Hello. The vacuity scan is the gate's check that no theorem is a "for all" over an empty domain (`LEAN.md` § The gate). Its law skips refutations —
declarations that conclude `False`, whose binders are meant to be empty. FS131-T1, the job just before yours, extended the scan to the Lean backlog's
new carrier types (commit `49c3abb8`; its record `plans/FS131-T1-vacuity.md`), and found that the refutation test is wider than the law.

## Why this job

The backlog's waves state many theorems whose conclusion is an inequality — wave 1's `Plane.AeColouring.dist_ne_one` concludes `dist x y ≠ 1` — and
wave 2, planned now, states more over measurable colourings. Each such theorem is currently skipped as if it were a refutation, so if its carrier were
empty the gate would say nothing: the failure this gate exists to catch.

## The defect

As FS131-T1 reported it:

> - tool defect — a conclusion `≠`/`¬` reads as a refutation (reducing telescope gives `… → False`), so a theorem like `AeColouring.dist_ne_one` (c : AeColouring k) … : dist x y ≠ 1 makes no site; at a concrete empty k it would be silent — preexisting law (Vacuity.lean `carriersOf`), not changed here; wave 2 statements concluding `≠`/`¬` are outside the scan — scripts/Vacuity.lean carriersOf
> — source: data/fs131/reports/FS131-T1.md

The law it should match:

> **The law:** a statement is
> — source: LEAN.md § The gate

(the sentence continues there: "vacuous exactly when some `∀`-binder has an empty domain; … a declaration concluding `False` is a refutation and is skipped.")

## Done means

1. **The defect reproduced first**, on `main`: a planted theorem over a concrete empty carrier (`(c : AeColouring 1)`, say) with conclusion `x ≠ y`, and
   another with conclusion `¬ P`, each raising no row today; logged in your record.
2. **The fix**: a declaration is skipped as a refutation only when its stated conclusion, after its binders, is `False` itself (decide, and write in
   the docstring, how you treat `¬ P` stated as such versus `P → False`, and why) — never because `≠` or `¬` unfolds to `→ False`. The two plants read
   VACUOUS; the same shapes at a variable `k` read GENERIC; a genuine refutation (conclusion `False`) stays skipped.
3. **Self-test controls** for both new shapes, and a control that a genuine refutation is still skipped, in `scripts/vacuity-controls.lean`;
   `./scripts/vacuity.sh --self-test` green with every control firing, T1's fourteen included.
4. **`main`'s gate green with the counts reconciled**: `./scripts/vacuity.sh` on `main`; `refutations-skipped` will fall and `sites` rise — explain every
   moved declaration (an `#eval` or a list from the scan naming them), and name any new UNKNOWN or VACUOUS. A new VACUOUS on `main` is a finding about a
   theorem, not a tool failure: stop and message me with it. If a new UNKNOWN would have to enter the baseline, stop and message me instead: the
   baseline only shrinks.
5. **Drafts** in your record under `## Drafts for the front page`: the new counts for `CLAUDE.md` § The gate and `scripts/vacuity-baseline.txt`'s header,
   the self-test's new control count for `LEAN.md` § The gate (it reads "fourteen" now), and, if the law's sentence in `LEAN.md` needs a clause to say what
   the fix decided, that clause. I file them; you do not edit those three files.
6. Your record, with "Theorems this phase proved" (none — a tooling job), and the report in standing rule 11's form.

## What is yours to decide

The shape of the fix in `scripts/Vacuity.lean` (T1's record says where the telescope reduces; `carriersOf` is the function named), and the treatment of
`¬ P` written as such. If matching the law exactly would drown the signal or misclassify a family the library relies on, say so with the measurement.

## The machine

The main tree's build is current as of T1 (`./scripts/build.sh`, 440/440). Builds through `./scripts/build.sh` under the slot
(`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`), never `lake build`; up to two builds may run at once across trees when
the slot admits them (inventory ruling 5). Commit by explicit path on `main` and push: `main`'s gate must read green after each commit.
