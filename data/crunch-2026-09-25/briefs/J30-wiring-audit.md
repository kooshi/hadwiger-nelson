*Brief for crunch job **J30**: the documentation and wiring audit ("the bookkeeper"). Opus 5.5, 2026-09-25. Written by the product
owner at Kooshi's request; it goes to the head of the queue.*

Hello. You are de Bruijn (`DEBRUIJN.md`), working as **the bookkeeper** in the Lean 4 Hadwiger–Nelson workspace
`/home/kooshi/source/lean-dir`. The house rules are `CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md`; read all three from disk.
**`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief; read it in full.** I'm the product owner; I coordinate and
review by artifact.

**If your record already exists, you are resuming:** read it and this brief, check the last SAVED stage against
`git log -- plans/CRUNCH-2026-09-25-INDEX.md`, and continue at the first stage not SAVED. Redo nothing saved.

## Why this job exists — Kooshi's words

> "Inject an Opus bookkeeper into the queue to verify the current documentation. I'm paranoid about losing any of this work, or having
> any of it on disk, but not wired in in such a way that it's easy to find from related things."

Two failure modes, then, and you are the check on both:
1. **Lost:** work that exists only in a scratch directory (which is RAM here and dies with the session), only in an uncommitted file,
   or only in a commit that never reached `origin`.
2. **Orphaned:** work that is on disk and committed, but that nobody reading a related stub, ledger row, grokking, milestone plan or
   earlier derivation would ever find — no pointer leads to it.

Today (2026-09-25) produced a great deal: FS-89's close, then a 16-hour crunch running three milestones at once — M1 (FS-91, character
colourings: `plans/FS91-character-local-global.md`), M2 (the kernel lane: `plans/M2-kernel-lane.md`), M3 (colourings no character
gives: `plans/M3-exotic-colourings.md`) — with some thirty jobs, each leaving a record, tools, data, a brief and a report. The close
jobs that will fold all this into `CLAUDE.md` and `LEDGER.md` come later; until then the only map is what you build.

## Scope

Everything committed since `2026-09-25T00:00` (`git log --since=2026-09-25T00:00`, about 240 commits), plus the session's scratch
directory (below). Earlier work only where today's work bears on it (a stub it re-aims, a row it corrects, a derivation entry it
extends).

## Stages (each saved and committed, headed `Stage n — SAVED` in your index file, before the next starts)

1. **Nothing lost (about 80k) — do this first; it is the urgent half.**
   - `git status`, `git log origin/main..main` (unpushed commits), untracked and modified files: list each with the job that owns it
     (by path convention: `tools/crunch_<job>_*`, `data/<m>/<job>/`, the record path in the job's brief). A file owned by a **running**
     job (below) is left alone and listed as "in flight". Anything else uncommitted: say whose it is and commit it by path only if it
     is plainly a finished job's product; otherwise list it for me.
   - **The scratch sweep.** The session's scratch directory is
     `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/` — **skip every `owner-*`
     directory** (the owner's; it holds identifiers that must stay out of the repository) and skip `locks`. For every other directory
     and loose file, classify it:
     (a) **already in the repository** (same content, or a successor file the record names) — list it, one line;
     (b) **work product not in the repository** — a derivation, a record draft, a tool, a result table, a certificate, a transcript a
         record cites — copy it into `data/rescued-2026-09-25/<same relative path>/` and commit it (text files up to about 5 MB each);
         a larger or binary file goes to `~/source/lean-dir-rescue/<same relative path>` on disk (not `/tmp`), listed in your index;
     (c) **a paper** (PDF or extracted text of a paper): check `~/source/library/pdf/` and `~/source/library/` for it; if absent, copy
         it there under a descriptive name (`Author<year>-<short-title>.pdf`) and note the `BIBLIOGRAPHY.md` entry it belongs to (you do
         not edit `BIBLIOGRAPHY.md` — propose the line, stage 5);
     (d) **scratch junk** (a throwaway script whose output is recorded elsewhere, a temporary file) — list it, leave it.
     A scratch directory belonging to a **running** job (its name matches the job's brief) is listed "in flight" and not copied.
   - Check every commit hash that any `data/crunch-2026-09-25/reports/*.md` names exists (`git cat-file -e`), and that every record's
     `SAVED` stages appear in `git log -- <record>`.
   - Push (`git push origin main`; never force) once your stage commit is in. Save.

2. **The index, M1 (about 80k).** Create `plans/CRUNCH-2026-09-25-INDEX.md`. For milestone M1, per job: brief, record, tools, data,
   report, commits. Per **result** — every line under each record's "Theorems this phase proved" heading and every report's RESULT
   line: a one-line statement, its grade, its **verification status** (one mind / two independent derivations / blind-verified, and by
   which job), and its address (file and section). Per **correction owed** and **held item**: its address and whether the close
   inventory `plans/FS91-close-inventory.md` carries it. Save.

3. **The index, M2, M3 and FS-89's close (about 70k).** The same for M2 (`plans/M2-close-inventory.md`), M3
   (`plans/M3-close-inventory.md`), and today's FS-89 close (`plans/FS89-close-inventory.md`; rows 95–97; `plans/FS89-derivation.md`).
   For M2, also each new Lean declaration's file and line and whether `scripts/Axioms.lean` audits it. Save.

4. **Wiring (about 70k).** Build the **reverse index**: for every older thing today's work bears on — each stub file
   (`plans/STUB-*.md`), each `LEDGER.md` row, each grokking G1–G76, each `plans/FS89-derivation.md` entry, each earlier derivation
   entry a result extends or corrects — the crunch addresses that bear on it. Then wire it in:
   - append to each affected **stub file** and each **milestone plan** a short block headed
     `## Where the 2026-09-25 work on this lives` listing **addresses and neutral titles only** — no results, no verdicts, no
     statements (see "Blindness", below) — plus a pointer to `plans/CRUNCH-2026-09-25-INDEX.md`;
   - where a **closed** record carries a statement now known to need correcting (for instance `plans/FS89-derivation.md`'s "Notation"
     and FS89-CL2, whose "archimedean" must read `Hom_ℚ(F(i), ℝ) mod 1`), add a one-line banner at that entry pointing to the source
     of the correction (its file and section). A banner says a correction is owed and where; it does not rewrite the entry — the close
     does that;
   - **cross-check each close inventory against the records**: every result under a record's "Theorems this phase proved" heading and
     every correction owed or held item must have an inventory line. Append the missing ones yourself, as the owner's pen (the format is
     the clerk brief's, `data/crunch-2026-09-25/briefs/J00-clerk.md` §3; take the next row number from the file's tail; no clerk runs
     while you do). Save.

5. **For the front page, and the report (about 30k).** The files `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md` and
   `BIBLIOGRAPHY.md` are the front-page lane's alone; you do not edit them. Instead, write in the index a section
   **"Proposed pointers for the front-page job"**: every place in those four files where a reader would need a pointer to today's work
   and none exists (with the exact line to add), and every bibliography entry a rescued paper needs. Save, push, report.

## Blindness — what you must not leak

Blind verifiers are running or queued. They are fenced from other jobs' records; your writes must not carry results into files they
read.
- **Your index holds results, so it is a fenced file for every blind job.** I am telling the running ones; the queued ones' launch
  messages will say so.
- **Pointer blocks and banners carry addresses and neutral titles only**, never a statement, verdict, number or route — a blind verifier
  may read a stub file or an FS-89 derivation entry as an input.
- **Running now — read their files if useful, write nothing into them, message none of them:** J10b (record
  `plans/FS91-S1V-character.md`), J11 (`plans/FS91-S1V-six.md`), J15 (`plans/M2-S2K-route-c.md`, `Proofs/HadwigerNelson/Transcendental.lean`),
  J18 (`plans/M3-S1A-rank-one.md`), J21 (`plans/M3-S1D-windows-five.md`). I will tell you if this list changes.

## Rules

- **No subagents.** You may not spawn subagents, forks or workflows — delegation here is one level deep (`CLAUDE.md` § Delegation).
  Reason: staffing is Kooshi's budget decision, and I can only review work I know about. If the work outgrows your context, stop at a
  saved stage and tell me what is left; a successor on this brief continues. That is a good report.
- **Never judge the mathematics.** You record grades and verification status as the records and reports state them. Where a record and
  a report disagree about a result's grade or status, list both with addresses; do not resolve it.
- **Never write an agent id** into any file; ids are the owner's.
- **Never edit** a frozen tool (`tools/fs58_*`, `tools/fs61_*`, `tools/fs66_*`, `tools/fs73_cert_check.py`, `tools/fs73_census_check.py`,
  `tools/fs73_theta_check.py`, `tools/fs73_theta_struct_check.py`, `tools/fs73v2_check.py`, `data/fs73/coxeter-c3/certcheck.py`), a Lean
  file, a running job's files, or the four front-page files.
- **No finite-witness search** (the ban to 2026-10-01) — nothing here needs one; keep the "would have searched here" log anyway (it
  will be empty, and saying so is the log).
- **Commits by explicit path** (`git add <new files>`, then `git commit <paths> -m …`, never a bare `git commit`; run `git diff -- <path>`
  first and confirm every hunk is yours). Neutral subjects: "J30: stage n". End commit messages with your harness's attribution lines.
  Push after each stage; never force-push.
- **Jobs** over about 2 GiB or 2 minutes run under `scripts/slot.py --mem <GiB> --cpus <N> -- <cmd>`; /tmp is RAM. Never run `lake build`.
- **Your scratch directory:** `…/scratchpad/j30/` (under the path above).
- **Budget:** about 350k by the harness's count; hand back with the index saved by 420k. Agents' own counts run at 55–70 % of the
  harness's. Stage 1 matters most; if you must stop early, stop after a saved stage.
- **Report** in the fixed ≤ 12-line form (standing rule 9) to `data/crunch-2026-09-25/reports/J30.md`, committed, and sent to me by
  SendMessage `to: "main"`: after stage 1 (marked STAGE 1 SAVED — I want the rescue result early) and at the end. Its RESULT line says
  how many items were rescued, how many were orphaned and are now wired, and how many inventory lines you added. Keep your turn's final
  text content-free: "J30 idle; report sent to the owner by SendMessage".

Thank you. Kooshi asked for this one by name; it protects everything else the crunch does.
