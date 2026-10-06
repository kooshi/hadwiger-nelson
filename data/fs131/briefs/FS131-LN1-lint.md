# Brief FS131-LN1 — the environment linters over `main`, measured: `lake lint` once, with a firing control, counted by linter and by module

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-LN1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: a short measurement job — run the environment linters (`lake lint`) once over the library as it stands on `main`, show the run can fail, count what it reports by linter and by module, and propose how and when to clear it; change nothing in the library
  launch: now, beside FS131-CC2 (the collar bend's lane C, on `fs131-w5k`) and FS131-IR1 (the procedure's last steps, on `fs131-w5c`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job if Lake starts to rebuild anything beyond running the lint driver, if the run needs more memory than the slot gives, or for a question you cannot work around; the report goes to `data/fs131/reports/FS131-LN1.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full (§ The gate above all), and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-lint-measurement.md` (new, on branch `fs131-wop`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop` (branch `fs131-wop`, which is `main`'s line: fast-forward it to `origin/main` first): `plans/FS131-lint-measurement.md`, `tools/fs131_ln_*.py`, `data/fs131/ln/`, `data/fs131/reports/FS131-LN1.md`; one library file of your choice for the planted control only, restored byte for byte before you commit anything; **not** any other file under `Proofs/`, `scripts/`, `lakefile.toml`, the shared `.lake/packages`, nor `main`
  budget: about 150k by the harness's count, as guidance; hand back at a saved stage before about 250k — read your token count at every saved stage

Hello. This is a short measurement, and it comes from a finding of the last landing job. The milestone, FS-131, turns this project's hand-derived results
into kernel-checked ones; seven landings have reached `main` so far (waves 1–4, Woodall's chain, MERGE and OPEN), adding several thousand declarations. Each
landing ran the build, the axiom audit, the vacuity scan and the architecture check. None ran `lake lint`, the environment linters; "linters silent" was read
from the build's warnings. By precedent that is in order — the linters run once, at a milestone's close — but nobody knows what they will say about this
much new text, and I would rather know the size now than at the close. You measure it. You fix nothing.

## Why this job

A milestone is Closed only when its module passes the gate, and the gate's list includes the linters. The finding, and the ruling that launches you:

> 414. **OPEN LANDED on `main`, held in the kernel: FS131-OL1 done** (harness ≈ 342k by the task notice; record `plans/FS131-IO-implementation.md`, Stages 16–20
> — source: plans/FS131-close-inventory.md

> 415. **Rulings on OL1's held items, and its slot.** (a) **Dates in filed counts are the gate logs' UTC date** (as the inventory's). (b) **A landing's
> — source: plans/FS131-close-inventory.md

## The statements

There is no theorem in this job. What the gate says, how the lint driver is configured, and how the last close ran it:

> Elaboration is the floor: the build green, zero `sorry`, `#print axioms` clean on the public surface (`scripts/axioms.sh`), and `./scripts/axioms.sh --self-test` green (23 planted faults, each watched to fire, two of them partners that must pass), linters
> — source: LEAN.md

> # `lake lint` — WORKFLOW's "linters silent" gate item, which errored with "no lint driver
> — source: lakefile.toml

> lintDriver = "batteries/runLinter"
> — source: lakefile.toml

> 2. **`lake lint`, once** (the owner's ruling: it runs at M2's close only, right after the green build, under the slot:
> — source: data/crunch-2026-09-25/briefs/J23b-M2-close-math.md

>    rebuild anything beyond the lint driver itself, stop it (by pid, verified by effect) and report — do not let Lake build the library
> — source: data/crunch-2026-09-25/briefs/J23b-M2-close-math.md

> RESULT: M2 closed, verdict Paid (kernel). Gate green (stage 0): build no-op 0 warnings; lake lint passed over 11,817 decls with a firing control; axioms 1,146 records / 1,130 clean / 11 axiom-free / 5 purchases (+21 record-named lines); vacuity 7051/304/279/257 + self-test OK; architecture PASS; 0 sorry. Kernel register plans/M2-derivation.md (226 decls, all ≤ standard three; 12 hand entries). Drafts in §R-close 4a–4f: 5 ledger rows (next-a…e), 12 § B lines + 9 kernel-column changes, 23 CLAUDE.md drafts (net +2,913 bytes, machine-checked by data/m2/j23b/claude_md_drafts.py), FRONTIER-STUBS rows, 5 stub banners, bibliography.
> — source: data/crunch-2026-09-25/reports/J23b.md

and a firing control from an earlier milestone, as a pattern:

> | `lake lint` negative control | a planted `def fs73LintPlant (n m : ℕ) : ℕ := n` made it exit 1, naming `Proofs.HadwigerNelson.Kempe` and the unused `m`. Then the file was restored (sha256 matched the saved copy), rebuilt, and lint passed again | terminal only |
> — source: data/fs73/records/phase-P5.md

## Done means

1. **Your readback first**: check every quotation above against its source; in the worktree, `git merge --ff-only origin/main`; build once under the slot
   (expect it up to date, 0 warnings); open your record with what you may and may not change. Commit and push.
2. **The run**: `lake lint`, once, under the slot (`/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- lake lint`; two other trees are
   building, so on exit 75 wait ten minutes and retry; if the linter is killed for memory, say so and message me before raising it), its whole output saved
   under `data/fs131/ln/` and its exit status read from the tool itself, never through a pipe. The driver's binary is already built
   (`/home/kooshi/source/lean-dir/.lake/packages/batteries/.lake/build/bin/runLinter`, in the packages directory every worktree shares by symlink). **If
   Lake starts to rebuild the driver or anything else, stop it by PID, check by effect that it stopped, and message me** — two other trees are compiling
   against that shared directory, and the library is built only through `scripts/build.sh`.
3. **The control, watched to fire**: plant one fault the linters must catch (an unused argument in a new definition, as FS-73's did) in a module near the
   top of the import graph, so the rebuild is small — `OpenMove` is imported by `Proofs.lean` alone; build through `scripts/build.sh`; run the linters again
   and see the plant named at its source position with a failing exit status; restore the file byte for byte (a checksum before and after), rebuild, and
   show `git status` clean. If the first run already fails, the control still matters: it shows the plant is reported among the rest.
4. **The count**: every finding, by linter and by module, and split between modules this milestone added and older ones (say how you drew the line); the
   ten modules with the most; for each linter, three findings quoted in full. A script of yours makes the table from the saved output, with a control.
5. **The proposal**: for each linter with findings, what clearing one takes — a docstring, a `nolint` with its reason, a renamed or removed argument (which
   changes a statement, and so needs my ruling: say how many are of this kind, and how many sit on a hypothesis a ruling kept on purpose, such as an
   underscore-named `_hF`) — a price for the whole, and whether it is better cleared now, wave by wave, or once at the close. If the run is clean, that is
   the result: say so, with the declaration count it covered.
6. **Your record**, stages headed "Stage n — SAVED (FS131-LN1)"; the report in standing rule 11's form. Leave no background process running, and keep
   everything the record cites under `data/fs131/ln/`.

## What is yours to decide

How the findings are parsed and counted, where the plant goes, and what the proposal recommends — you are closer to the linters' output than I am, and a
recommendation I did not expect is welcome. If the run cannot be made safely beside two building trees, say what it would need and stop there; that is a
good report too. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.
