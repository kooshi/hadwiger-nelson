# FS-53 phase A — the finding side: α and six-colourings across the window

*Runner: de Bruijn (experiment runner), 2026-09-15, desktop (16 physical cores / 32 threads).
A second agent holds the two graphics cards and a little CPU, so this phase runs at **≤ 24 threads at any instant**.
Scope: the seven **prime** members 23, 31, 43, 47, 59, 67, 79. `q = 27 = 3³` is excluded — both Rust tools take
`--p <PRIME>` only — and goes to a separate work order.*

## What this phase can and cannot say

Both instruments are local searches. `plane-independent` reports a set only after a pairwise sweep from the
definition; it can never say a larger set does not exist. `plane-colour` reports a colouring only after an
independent sweep of every vertex pair; it can never say no colouring exists. **Every `not_found` here is a null at
a stated budget, never a refusal, and every largest set reached is written "plateau at N under budget B", never as
α.**

## Controls, before anything was launched

| control | result |
|---|---|
| `plane-independent --self-test` | 28 controls, 28 passed (`log/selftest-indep.txt` in the job scratch) |
| `plane-colour --self-test` | 25 controls, 25 passed |
| planted failure for the verification step | see § The plant, below |

## The run schedule, and the resume command for every stage (written BEFORE launch)

Scratch (records and logs, not committed): `/home/kooshi/.claude/jobs/b1507518/tmp/phaseA/{rec,log}/`.
**One `--out` path per run, never shared** — `plane-independent`'s temporary file is a fixed `<path>.tmp`, so two
concurrent runs on one path can rename a hybrid record (the engine's D91, ruled "manageable by convention" in
`plans/STUB-sixth-colour.md` §S13.2 A0.3). Every run's `--out` below is unique to that run.

Both tools rewrite the whole record through a temporary file and a rename at **every progress tick**, so a run
killed at any instant leaves a complete, already-verified record. **That is this phase's checkpoint**, and it lives
in the job scratch, outside `build/`. The driver is a snapshot copy (`build/…` is never used); it is launched under
`setsid` with its pgid in `phaseA/pgid.txt`, and it is stopped by `kill -- -<pgid>`, never by matching a command line.

| stage | what runs | budget | threads | resume command |
|---|---|---|---|---|
| A.1 s1 | free α search, all 7 members concurrent | 900 s each | 7 × 3 = 21 | `phaseA/drive.sh s1` |
| A.1 s2 | α under each rotation order dividing `q+1`, and the line quotient | 180 s each | 8 × 3 = 24 | `phaseA/drive.sh s2` |
| A.1 s3 | free α search chained with `--start` from the best set of s1+s2 | 3600 s at 23, 31; 1800 s elsewhere | 22 | `phaseA/drive.sh s3` |
| A.2 s4 | `plane-colour --k 6`, all 7 members concurrent | 1800 s each | 7 × 3 = 21 | `phaseA/drive.sh s4` |
| A.2 s5 | `plane-colour --k 5` at 23; `fplane.py equivariant` at the prime members | see below | ≤ 24 | `phaseA/drive.sh s5` |

Every stage is idempotent: a re-run overwrites its own scratch records and nothing else. A stage killed part way
is resumed by re-running it; the runs that already finished cost their budget again, which is the price of not
having a stage-level checkpoint, and is minutes rather than hours at every stage but s3.

*(The results tables below are filled in as the stages land.)*
