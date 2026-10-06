# FS131-LN1 — the environment linters over `main`, measured

*The record of job FS131-LN1 (de Bruijn, the implementer). Brief: `data/fs131/briefs/FS131-LN1-lint.md`. Branch `fs131-wop`, which is
`main`'s line. Everything this record cites is under `data/fs131/ln/`.*

## Theorems this phase proved

None. This is a measurement job: it proves no theorem and changes no declaration of the library.

## Stage 1 — SAVED (FS131-LN1)

*2026-10-06T03:20Z (2026-10-06 03:20 UTC). Tree: `.claude/worktrees/fs131-wop` at `333ecaa1`.*

### What I may and may not change

- **May write**: this record; `tools/fs131_ln_*.py`; `data/fs131/ln/`; `data/fs131/reports/FS131-LN1.md`.
- **May edit, for the planted control only**: one library file of my choice, restored byte for byte (checksum before and after) before
  anything is committed. The plant is never committed.
- **May not change**: any other file under `Proofs/`; `scripts/`; `lakefile.toml`; the shared `.lake/packages` (every worktree's
  `.lake/packages` is a symlink to `/home/kooshi/source/lean-dir/.lake/packages`); `main`. No statement, no docstring, no `nolint`:
  the job fixes nothing.
- **May not run**: `lake build`, bare or named. Builds go through `scripts/build.sh` under `scripts/slot.py`. `lake lint` is the one
  Lake command this job runs, and it must not rebuild anything.

### The readback

Every quotation of the brief, checked against its source by `tools/fs131_ln_quotes.py` (a quoted line must occur character for
character inside one line of the source file):

| brief line | source | verdict |
|---|---|---|
| 30 | `plans/FS131-close-inventory.md:3726` (item 414) | verbatim |
| 33 | `plans/FS131-close-inventory.md:3748` (item 415) | verbatim |
| 40 | `LEAN.md:162` | verbatim |
| 43 | `lakefile.toml:4` | verbatim |
| 46 | `lakefile.toml:9` | verbatim |
| 49 | `data/crunch-2026-09-25/briefs/J23b-M2-close-math.md:24` | verbatim |
| 52 | `data/crunch-2026-09-25/briefs/J23b-M2-close-math.md:26` | verbatim |
| 55 | `data/crunch-2026-09-25/reports/J23b.md:2` | verbatim |
| 60 | `data/fs73/records/phase-P5.md:124` | verbatim |

9 quoted lines, 9 found verbatim, 0 missing (`data/fs131/ln/quotes.txt`, exit 0). **The check's control**
(`--self-test`, `data/fs131/ln/quotes-selftest.txt`, exit 0): one character altered in each quoted line in turn, 9 plants, each
reported alone at its own line; a brief with no quotation fails ("nothing was checked") instead of passing.

One thing the brief's header says that the quotations do not carry: the brief is dated 2026-10-06 and this session's clock reads
2026-10-06 03:20 UTC, which is 2026-10-06 03:20 UTC. The two agree under inventory item 415 (a): dates are the gate logs' UTC date.

### The tree

- `git merge --ff-only origin/main`: `7189bdcf..333ecaa1`, fast-forward. The five files it brought are `CLAUDE.md`, the brief,
  `plans/FS131-close-inventory.md`, `plans/SESSION-HANDOFF-2026-10-04.md` and `tools/claude_md_fact_audit.py`: nothing the build reads.
- **The build, once, under the slot** (`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`): exit 0,
  read from the tool into `data/fs131/ln/build-readback.exit`. The slot waited (the ledger held 80 GiB in two other trees' builds
  against a budget of 90) and then admitted it. `==> build: OK — all 1767 modules already up to date, nothing built, 0 module(s) with
  warnings, 2s`; the gate log is `All targets up-to-date (5750 jobs).` (`data/fs131/ln/build-readback.out`,
  `data/fs131/ln/build-readback.gate.log`, a copy of `build/gate/build/20261006T031956Z-517785.log`).
- The built root module names the newest landing: `.lake/build/lib/lean/Proofs.olean` contains the string `OpenMove`.

### How the linters run here, read from the source before running them

`lake lint` (Lake 5.0.0, `$(lean --print-prefix)/src/lean/lake/Lake/CLI/Main.lean:1057`, `Lake/CLI/Actions.lean:89`) does two things.

1. **It asks Lake to build the driver** — `runBuild exe.fetch buildConfig` on the executable `batteries/runLinter` — and then runs
   that binary with `lintDriverArgs` (`["Proofs"]`) and whatever follows `--` on the command line. This is the one place Lake itself
   can start compiling: if it judges the driver, or a Batteries module the driver imports, out of date, it rebuilds into the shared
   `.lake/packages/batteries/.lake/build`. Lake's own `--no-build` option reaches this call (`noBuild := opts.noBuild`,
   `Main.lean:137`): with it Lake exits instead of building.
2. **The driver** (`.lake/packages/batteries/scripts/runLinter.lean:100–176`) looks for `Proofs.olean` and
   `Batteries/Tactic/Lint.olean`; if either is missing it spawns `lake build +<module>` — the second place a build can start, and the
   one that would build the library outside `scripts/build.sh`. Its own `--no-build` flag makes it exit 1 instead. It then imports
   `Proofs` and `Batteries.Tactic.Lint`, takes every declaration whose module's root is `Proofs` (`getDeclsInPackage`), runs every
   enabled `@[env_linter]` in the environment, slow ones included, and removes the pairs listed in `scripts/nolints.json` — a file
   this repository does not have, so nothing is removed. If any linter reports, it prints the findings and exits 1; otherwise it
   prints `-- Linting passed for Proofs.` and exits 0.

**What follows for the run.** A passing run prints one line and no count; a failing run prints
`-- Found N errors in D declarations (plus A automatically generated ones) in Proofs with L linters`. The driver's `--trace` flag adds
one line per linter, `(2/2) Passed!` or `(2/2) Failed with n messages`, which is the positive signal for the linters that found
nothing, and a per-linter count to hold the parser against. So the run is

```
scripts/slot.py --mem 40 --cpus 8 -- lake lint --no-build -- --no-build --trace
```

It is the brief's `lake lint` with three additions, none of which changes what is linted: Lake's `--no-build` (before `--`) and the
driver's `--no-build` (after it) turn "watch for a rebuild and kill it by PID" into "a rebuild cannot start: the tool exits non-zero
and says why"; `--trace` adds lines and changes no verdict. The M2 close ran the same pair of driver flags on its second run
(`plans/M2-kernel-lane.md` §R-close stage 0, row 2: 14 linters, 3.5 s wall, 4.2 GB peak, over 11,817 declarations).

Both `.olean`s the driver needs are present (`.lake/build/lib/lean/Proofs.olean`;
`.lake/packages/batteries/.lake/build/lib/lean/Batteries/Tactic/Lint.olean`), and the driver's binary is built
(`.lake/packages/batteries/.lake/build/bin/runLinter`, 240 MB, sha256 `21bc14b3…16e2fcf3`, Lake's `runLinter.hash` `543fc84530ef03e7`).
Its checksum is taken again after every run: a changed binary is a rebuild that happened.

### Where the line between this milestone's modules and older ones is drawn

By git, on the library's files. The last commit before FS-131 that touches `Proofs/` is `077fa8b0` (X11K3, 2026-09-26); the first
FS-131 one is `3ec3b6c2` (FS131-K1, 2026-10-03).

- **Added by FS-131**: a module whose file does not exist at `077fa8b0`. There are 52 (`git diff --name-status 077fa8b0 HEAD --
  Proofs/`: 52 added, none modified, none deleted; `Proofs.lean`, the import list, is the only older file FS-131 changed).
- **Older**: a module whose file exists at `077fa8b0`: 1,714 files under `Proofs/`, each byte-identical to its state there.

A second line is kept beside it, because it bears on the proposal: **the last recorded passing `lake lint`** is the M2 close's, at
`39513500` (2026-09-25). Between it and `077fa8b0` seven modules were added and one changed (`Instances/SqrtFortySeven`,
`Instances/SqrtOneSixSeven`, `Instances/SqrtOneSixSeven/Cert`, `SpectralChain`, `ThetaCert`, `ThetaPlane`, `ThreeColour`;
`Transcendental` changed). I found no record of `lake lint` run over those; they are "older" by the first line and "never linted" by
the second, and the count reports them as their own class.
