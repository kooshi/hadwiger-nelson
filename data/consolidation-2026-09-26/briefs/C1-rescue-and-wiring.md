*Brief for job **C1**: nothing lost, then everything findable — the ×2×3 crunch's rescue, index and wiring. Opus 5.5, 2026-09-26. Written by
the product owner. **Its template is J30's brief** (`data/crunch-2026-09-25/briefs/J30-wiring-audit.md`): read it in full and follow its
method; this brief overrides it where they differ.*

Hello. You are de Bruijn (`DEBRUIJN.md`), a careful bookkeeper, in `/home/kooshi/source/lean-dir`. Read `CLAUDE.md`, `WORKFLOW.md` and
`DEBRUIJN.md` from disk. **`data/consolidation-2026-09-26/briefs/STANDING-RULES.md` is part of this brief.**

## Kooshi's words (2026-09-26, verbatim)

> "Now, next, I want to do a documentation consolidation. Let's audit our main files and just make sure that our citations are clean, all
> findings are wired in, all files in /tmp that can't be regenerated are rescued, and all claims are brought up to date with our new evidence."

Your share is **the rescue** and **the wiring**. Two other jobs run beside you: C2 (citations, `BIBLIOGRAPHY.md`) and C3a (claims in `CLAUDE.md`,
`LEDGER.md`, `CLOSED-QUESTIONS.md`). Do not edit those four files.

## Scope

The 2026-09-26 ×2×3 crunch (`plans/CRUNCH-2026-09-26-x2x3-queue.md`, all sections; its jobs X00–X31, the Lean jobs X11K/X11K2/X11K3, the clerk
folds J00, the planner, the advisor), and the post-crunch jobs of 2026-09-26 that `plans/CRUNCH-2026-09-25-INDEX.md` may not yet cover (J51,
J51D, J51V, J52, J52K, J53, J53b, J54, J55 — check, and extend that index if they are missing).

## Stages (each saved and committed before the next)

1. **Nothing lost — do this first.**
   - `git status` (tracked changes, untracked files — `data/m2/j23b/signatures.txt` has been untracked for days: decide what it is and commit
     it or record why not), and unpushed commits (`git log origin/main..main`).
   - **`/tmp` is RAM and dies with the session.** Survey `/tmp/claude-1000/` (2.0 GB; skip credential files) and any other `/tmp` paths the
     records name. For each file that a record, report or plan refers to, or that holds work (a derivation draft, a tool output, a certificate,
     a log a record cites), decide: **regenerable** (say by which command) or **not** — and rescue every non-regenerable one into the
     repository at the address its record expects (or `data/consolidation-2026-09-26/rescued/…` with a pointer from the record), or, if too
     large or not repository material, into `~/source/lean-dir-rescue/consolidation-2026-09-26/` with a line in your index. Large outputs
     (over about 1 GiB) go to disk under `~`, never the repository. The owner's job log is already at
     `~/source/lean-dir-rescue/owner-scratch-2026-09-26-x2x3/`.
   - Every record, report, tool and data path the crunch's reports name: does it exist, committed? List any that do not.
2. **The index.** Create `plans/CRUNCH-2026-09-26-x2x3-INDEX.md` in the shape of `plans/CRUNCH-2026-09-25-INDEX.md`: per job, its brief,
   record, report, tools, data, and the ledger rows / derivation entries it fed (rows 116–127; `plans/FS100-derivation.md` §2–§5; the close
   inventories `plans/FS100-x2x3-close-inventory.md` and `plans/FS100-x2x3-wave3-close-inventory.md`; the §R-close sections of
   `plans/FS100-three-field-lemma.md`). Extend the 2026-09-25 index for any post-crunch job it lacks.
3. **Wiring — the reverse index.** For every older thing today's work bears on — each stub file the results touch (FS-100, FS-59, FS-84,
   FS-98, FS-64, FS-96, FS-97, FS-48, FS-72, FS-62, FS-75, FS-60, FS-101, and any other the ledger rows 116–127 name), each milestone plan
   (FS-84's, row 88's, FS-89's …), and `plans/R88-derivation.md` — make sure a reader of that file finds today's result: add an
   **address-only pointer block** ("See: row 121; `plans/FS100-derivation.md` FS100-Q47; …") where none exists. Pointers, never results —
   the result's one home is its ledger row and its derivation entry. Record the reverse index in the index file.
4. **The report.**

## Rules

- **Touch only:** the two index files; pointer blocks in `plans/STUB-*.md` and in milestone plans (address-only, appended or in an existing
  "See also" block); rescued files; `data/consolidation-2026-09-26/`; `~/source/lean-dir-rescue/consolidation-2026-09-26/`. **Never** `CLAUDE.md`,
  `LEDGER.md`, `BIBLIOGRAPHY.md`, `CLOSED-QUESTIONS.md`, `plans/FRONTIER-STUBS.md` (C3b edits that later), Lean files, `scripts/`, frozen tools.
- Your record is the index file itself (stages headed `Stage n — SAVED`).
- **Budget:** about 250k by the harness's count; hand back by 350k.
- Report per standing rule 9 to `data/consolidation-2026-09-26/reports/C1.md`.

Thank you.
