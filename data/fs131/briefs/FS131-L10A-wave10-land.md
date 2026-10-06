# Brief FS131-L10A — wave 10's first landing: the four proved files joined, the unread arguments dropped, `main` merged, the full gate on one commit, and `main` fast-forwarded

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-L10A
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the landing implementer of wave 10's first pass — merge the three implementers' branches into one line, make the short list of ruled statement tidies, merge `main`, run the full gate on one commit with its newer steps, fast-forward `main`, and draft the counts for the filing
  launch: when a slot frees, in a tree of its own cut from the first implementer's tip; other jobs work on other waves in trees of their own and commit nothing to `main` but `plans/` and `data/`
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a merge conflict beyond the kinds named below, a gate step red for a reason you cannot repair within your touches (the vacuity scan reading a new site as vacuous or unknown, an axiom record outside the standard three, a name declared twice), a ruled tidy that does not go through as ruled (a caller you did not expect, a proof that reads the argument after all), or a question you cannot work around; the report goes to `data/fs131/reports/FS131-L10A.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-L10A-landing.md` (new, on branch `fs131-w10l`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10l` (branch `fs131-w10l`, cut from `fs131-w10` at `ace98a35`): the merges' files; the four files of `Proofs/HadwigerNelson/Arith/` the wave's first pass wrote (`CharacterColouring`, `SpectralInputs`, `StationaryRatio`, `StandingFive`) for the ruled tidies and their docstring lines, with any caller; `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `scripts/axioms-controls.txt`, `scripts/Vacuity.lean` and its controls and `scripts/vacuity-baseline.txt` as the gate's own procedures ask; `plans/FS131-L10A-landing.md`, `tools/fs131_l10a_*.py`, `data/fs131/l10a/`, `data/fs131/reports/FS131-L10A.md`; `main` only by the final fast-forward push; **not** `CLAUDE.md`, `LEAN.md`, `LEDGER.md`, `BIBLIOGRAPHY.md` (you draft their lines; I file them), no statement beyond the ruled ones, and nothing of the wave's second pass (the branch `fs131-w10k` and the three cut from it: their modules have open leaves and land later)
  budget: about 450k by the harness's count, as guidance; hand back at a saved stage before about 550k — read your token count at every saved stage

Hello. You are landing the first half of the arithmetic wave of the Lean backlog. The milestone, FS-131, turns this project's hand-derived
results into kernel-checked ones; waves 1–5 and a library of example maps are on `main`. Wave 10 is fourteen arithmetic rows. Its first
planner stated eleven of them in four files, and three implementers have since proved every leaf of those files — each on a branch of its
own, none of which has met the others or `main` since before wave 5 landed. You make them one line, tidy what three rulings left for this
moment, and put them through the gate. The wave's second pass (the finite-target floor and three more files) is still being proved and
lands after you.

## Why this job

A wave counts as held only when its declarations pass the full gate on one commit (the milestone's announcement rule,
`plans/FS131-close-inventory.md`); nothing with a `sorry` reaches `main`. This is that gate for twenty-one leaves' worth of results, among
them every unconditional clause of the standing-five field's row. Kooshi, on what the evidence must be:

> - **The artifact is the certificate plus the checker, never the search.** Commit the data a reviewer re-checks; never require them to
> — source: CLAUDE.md § The standard of evidence above rung B

The three implementers' hand-backs, the planner's, and the rulings in force (read each whole in the inventory):

> 493. **FS131-I10A done: all nine leaves of wave 10's first file pair proved — `SpectralInputs` and `CharacterColouring` hold no `sorry`, over
> — source: plans/FS131-close-inventory.md

> 494. **Rulings on I10A's held items, and its slot.** (a) **The two unread instance arguments are dropped from the statements** —
> — source: plans/FS131-close-inventory.md

> 506. **FS131-I10B done: all three leaves of wave 10's `StationaryRatio` proved, with no hypothesis from outside Mathlib** (implementer,
> — source: plans/FS131-close-inventory.md

> 507. **Rulings on I10B's held items, and its slot.** (a) **The seven unread arguments are dropped at the join, as ruling 494 (a) has
> — source: plans/FS131-close-inventory.md

> 519. **FS131-I10C done: all nine leaves of wave 10's `StandingFive` proved — with it every one of the wave's four first-pass files
> — source: plans/FS131-close-inventory.md

> 520. **Rulings on I10C's held items, and its slot.** (a) **"347 is attained by a place of `F`" is not made a row**: the filed
> — source: plans/FS131-close-inventory.md

> 509. **FS131-K10b done at its Stage 9: wave 10's second planning pass — the finite-target floor stated as two rows, the read-backs
> — source: plans/FS131-close-inventory.md

> 496. **FS131-MC1 done: the example maps are on `main` through the full gate — `a296e60d..edd6aa8d`, a fast-forward; gated commit
> — source: plans/FS131-close-inventory.md

## The statements

No statement changes but the ruled tidies. Heads of the three branches, as they stand there — after the merges each must print the standard
three (read each whole):

> theorem sp_if (I : Interface F) [Countable (unitRing F)] (hBH : BochnerHerglotz (unitRing F)) (hmul : I.MulStable)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10l/Proofs/HadwigerNelson/Arith/SpectralInputs.lean

> theorem spectral_carried_iff [IsProbabilityMeasure μ] (t : TopologicalSpace R)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10l/Proofs/HadwigerNelson/Arith/SpectralInputs.lean

> theorem ratio_prod_le {H : Type*} [AddCommGroup H] [MeasurableSpace H] [MeasurableAdd₂ G] [MeasurableNeg G]
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10b/Proofs/HadwigerNelson/Arith/StationaryRatio.lean

> theorem ratio_prod_le_iSup_levels {X Y : Type*} [AddCommGroup X] [MeasurableSpace X] [MeasurableAdd₂ X]
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10b/Proofs/HadwigerNelson/Arith/StationaryRatio.lean

> theorem seven_le_localBound (hFloor : StandingFloor 7) : 7 ≤ localBound standingField :=
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10c/Proofs/HadwigerNelson/Arith/StandingFive.lean

The gate's recorded state on `main`, which your counts are reconciled against:

> `declarations=13386 refutations-skipped=192 sites=1137`, `vacuous=0 stale=0 declared=3 witnessed=37 generic=1095 unknown=2`.
> — source: CLAUDE.md § The gate

## Done means

1. **Your readback first**: check every quotation above against its source; read the three implementers' reports and records — on your
   branch `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10l/plans/FS131-I10A-implementation.md`, and on theirs
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10b/plans/FS131-I10B-implementation.md` and
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10c/plans/FS131-I10C-implementation.md` (each ends with drafts and with what the
   join must know) — the planner's record `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10l/plans/FS131-w10-kernel-plan.md`, and the last landing's record for the gate's procedure
   (`/home/kooshi/source/lean-dir/plans/FS131-MC1-landing.md`, Stages 4–5). Build the branch once as given. Open your record. Commit and push.
2. **The merges**, each its own commit, each checked before the next: `git merge origin/fs131-w10b` (at `423cd8e8`), then
   `git merge origin/fs131-w10c` (at `8ee0d85b`). A trial of each on this tree's tip shows one conflict, `scripts/Axioms.lean` — three blocks at
   one anchor: keep every block. A conflict beyond that is a message to me. A merge is committed as a merge, the index holding the merge
   and nothing else, checked. Build. **The receipt that the first pass is whole**: zero `sorry` in the four files; every leaf the three
   reports name on exactly the standard three or a subset, with a control that fires; no statement of any side changed by the merges (by
   script, against each branch's tip).
3. **The ruled tidies** (rulings 494 (a), 507 (a); each with its callers and a script check that exactly the ruled statements changed):
   the two instance arguments the first implementer's proofs do not read — `[Countable (unitRing F)]` out of `sp_if`,
   `[IsProbabilityMeasure μ]` out of `spectral_carried_iff`; and the second implementer's seven, with the two weakenings its record names
   (`[MeasurableAdd₂ _]` four times, `[T2Space Y]`, `[SigmaFinite νX]`, `(hK : Antitone K)`; `[IsFiniteMeasure νY]` to `[SFinite νY]`, the
   index `ℕ` to any type) — **each row keeps its name on the general statement and its `_of_symm` / `_of_shrink` twin is deleted**, with
   its record in `scripts/Axioms.lean`. One that does not go through as ruled is left, said, and messaged. Then the lines the three reports
   leave for the join: `ARCHITECTURE.md`'s rows for the four modules ("skeleton" no longer), and in `sp_if`'s docstring the sentence
   `LEAN.md` § The gate asks of a theorem whose hypothesis has no Lean model yet (`Interface.NegCircle`: none on file; one is planned on
   the second pass's branch — an open gate item, to be listed in your drafts).
4. **`main` merged in**: this line last had `main` before wave 5 landed, so the merge brings wave 5 and the example maps. Trial it first
   and name the conflicts before you make it (foreseen: `scripts/Axioms.lean`, `ARCHITECTURE.md`, `Proofs.lean`, adjacency, keep-both; the
   name `Plane.conj_e`, declared twice on this line, is one declaration on `main` — take `main`'s). A conflict in a Lean file under
   `Proofs/` other than those is a message to me.
5. **The full gate on one commit**: `./scripts/build.sh` with zero warnings (count them); zero `sorry` in `Proofs/`;
   **the doubled-name check on the joined tree, after the build and before the axiom audit** —
   `/home/kooshi/source/lean-dir/scripts/slot.py --mem 16 --cpus 8 -- ./scripts/dupnames.sh`, then its `--self-test` under `--mem 4 --cpus 4`
   (with a doubled theorem name an axioms print can be clean over a `sorry` copy); `scripts/axioms.sh` clean, every record of the wave
   registered and within the standard three, `--self-test` green (controls' expected counts fixed where your state moves them, each shown
   red before and green after); `scripts/vacuity.sh` and `--self-test` green, the counts reconciled against the line above —
   **`StationarySet` registered as a carrier with its inhabitants** (`StationarySet.empty`, `StationarySet.parity`, `cantorLevel`; ruling
   507 (d)), and say how the scan classes every new site; a new site read as vacuous or unknown, or a request for a baseline entry, is a
   message to me with the scan's line; `tools/check_architecture.py` exit 0; **the guarded lint**,
   `lake lint --no-build -- --no-build --trace` under the slot with `--mem 8` (`LEAN.md` § The gate), silent; **the notes check**,
   `tools/fs131_qa4_notes.py`, no CONFLICT; **the records check** against the kernel's own list of theorems (`tools/fs131_l5_records.py`,
   as the last two landings ran it: every hand-written theorem of the wave has one record, on exactly the standard three or a subset).
   Save every step's log under `data/fs131/l10a/` and name them.
6. **The landing**: if `main` moved meanwhile, merge it again; when the new commits touch only `plans/`, `data/`, `.claude/`,
   `BIBLIOGRAPHY.md`, `LEDGER.md`, `LEAN.md`, say so with the diff that shows it, otherwise re-run the gate on the merged commit. Then
   `git push origin HEAD:main` from the worktree — a fast-forward only, never a force-push; on a rejected push, fetch, merge and try again.
7. **Drafts for the filing**, in your record under "Drafts for the front page (FS131-L10A)", each with the log line it comes from: the
   `CLAUDE.md` § Trust ledger sentence's counts; § The gate's two count lines; a `GATE_CHANGES` entry for `tools/claude_md_fact_audit.py`
   (the previous landing's receipts are `data/fs131/mc/receipt-axioms-final2.log` and `data/fs131/mc/receipt-vacuity-final2.log`); the
   implementers' drafts gathered and corrected for what the join changed (`plans/LEAN-BACKLOG.md` rows, `LEDGER.md` clauses, the plan's
   § 7.4 rows); **the named hypotheses each landed theorem rests on, by name** (`StandingFloor`, `Row123Chain`, `BochnerHerglotz`,
   `BochnerOn`, `Interface.MulStable`, `Interface.NegCircle`, the order bound, RQ₄, RQ₅ — the planner's § 5.5 table, checked against what
   landed); and **the open gate items at this landing** (a theorem whose hypotheses have no Lean model: `sp_if`, and any other you find).
   The kernel's sentence for the usable residue fields is "at least 347" (ruling 520 (a)).
8. **Your record**, stages headed "Stage n — SAVED (FS131-L10A)"; the report in standing rule 11's form, the wave's heads and record counts
   read from the gate's saved axioms log. Leave no background process running. Stopping at a saved stage with the gate red at a named
   check is a good report — say which check, its log, and what you would try next.

## What is yours to decide

The order inside each step, how to resolve keep-both conflicts, how the vacuity scan's new sites are registered under its own procedure,
and whether a tidy of item 3 is deferred. If the gate shows something no job could see from its branch — a record the audit reads
differently on the joined line, a note the notes check refutes, a name two of the three branches both declared — that is a finding: fix
what is within your touches and ruled, and message me for the rest. Do not weaken a check to pass it. Three failed attempts on one route is
a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.
