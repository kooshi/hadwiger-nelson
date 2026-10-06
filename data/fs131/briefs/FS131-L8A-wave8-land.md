# Brief FS131-L8A — wave 8's first landing: the two parallel branches joined, `main` merged, what the wave assumes declared, the full gate on one commit with its newest step, and `main` fast-forwarded

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-L8A
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the landing implementer of wave 8's first two planning passes — merge the second parallel implementer's branch into the first's, check that the joined line holds no open leaf, merge `main`, make a short list of docstring corrections, declare to the gate what the wave assumes, read every head's statement from the kernel, run the full gate on one commit, fast-forward `main`, and draft the counts and the front-page lines for the filing
  launch: now, in a tree of its own cut from the first parallel implementer's tip; other jobs work on other waves in trees of their own and commit nothing to `main` but `plans/` and `data/`
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a merge conflict in a Lean file, a declaration that still prints `sorryAx` after the join (at once: it means a leaf thought proved on the other branch is not, or its statement differs), a gate step red for a reason you cannot repair within your touches (the vacuity scan reading a new site as vacuous or unknown, an audit record outside the standard three, a name declared twice, the assumptions step asking for a declaration no record of ours explains), a head whose statement in the kernel differs from what its file shows, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-L8A.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-L8A-landing.md` (new, on branch `fs131-w8l`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8l` (branch `fs131-w8l`, cut from `fs131-w8c` at `0bdf6ea9`): the merges' files; the wave's modules under `Proofs/HadwigerNelson/Plane/RingCalculus/` — **docstrings only**, for the corrections listed below; `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `scripts/axioms-controls.txt` only if a control's expected count moves with your state; `scripts/Assumptions.lean` (its declared list only), `scripts/assumptions-ledger.txt` (by `--write-ledger` only); the vacuity scan's files where its own procedure sends you (`scripts/vacuity-baseline.txt` — its header's count lines only, after the scan's final run; an entry is a message to me); `plans/FS131-L8A-landing.md`, `tools/fs131_l8a_*.py`, `data/fs131/l8a/`, `data/fs131/reports/FS131-L8A.md`; `main` by the one fast-forward push this brief names; **not** any statement, definition or proof, any landed module beyond what a merge brings, `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md` (drafts for those go in your record)
  budget: about 450k by the harness's count, as guidance; hand back at a saved stage before about 550k — read your token count at every saved stage

Hello. You are landing wave 8 of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–5, the first half of wave 6 and wave 10 are on `main`. Wave 8 is the *ring calculus*: what the unit circle
about a vertex of a valid map (its *ring*) carries, in the class with no Siamese pair. Two planners stated it, and five implementers
proved every leaf they stated — the last two today, in parallel, each over the other's statements. No tree has held all of it at once.
You make it one line, the kernel checks the whole chain for the first time, and it goes to `main` through a gate that since today
also lists everything a theorem assumes.

## Why this job

A wave counts as held only when its declarations pass the full gate on one commit (the milestone's announcement rule,
`plans/FS131-close-inventory.md`); nothing with a `sorry` reaches `main`. Until the join, most of this wave's second half is proved
over a leaf proved on the other branch under the same statement. This job is where that becomes a kernel fact or shows a seam. The
hand-backs and rulings behind it (read each item whole in the inventory):

> 569. **FS131-I8A done at its Stage 5: wave 8's empty class is proved — `emptyNS` and its six leaves, `doubleTip`, `star_recip`; `star_anti` left open at its old statement** (implementer, Opus; harness 556k and 77 minutes by the task notice; record `fs131-w8a`'s `plans/FS131-I8A-implementation.md`; report `data/fs131/reports/FS131-I8A.md`; four commits, tip `e1e0c74d`; pushed, tree clean).
> — source: plans/FS131-close-inventory.md

> 572. **FS131-K8b done at its Stage 10: wave 8's second planning pass — nine semi-hub rows stated in two new modules with no hypothesis from wave 7; two rows left for a third pass** (planner; harness 609k and 48 minutes by the task notice; record `fs131-w8`'s `plans/FS131-w8-kernel-plan.md` Stages 6–10; report `data/fs131/reports/FS131-K8b.md`; commits `5d4e4d12`, `8d979793`; pushed, tree clean).
> — source: plans/FS131-close-inventory.md

> 586. **FS131-I8B done: wave 8's join — the two branches merged, the shared lemmas proved, and `star_anti` proved at its ruled statement** (implementer, Opus; harness 497k and 56 minutes by the task notice; record `fs131-w8b`'s `plans/FS131-I8B-implementation.md`; report `data/fs131/reports/FS131-I8B.md`; commits `bd694259`, the merge `9ddc32d2`, `d635a30a`, `216baaa4`, `6e0cf10d`; pushed, tree clean).
> — source: plans/FS131-close-inventory.md

> 592. **FS131-I8D, by message mid-job: a statement defect — five statements of `SemiHubPlaces` read "exactly four colours at `p`" and were stated with "at least four", which is four only at six colours** (source: I8D's message to "main", 2026-10-06 — the artifact is read at its hand-back).
> — source: plans/FS131-close-inventory.md

> 597. **FS131-I8C done: wave 8's `SemiHub` — all seventeen leaves proved as the planner stated them** (implementer, Opus; harness 572k and 54 minutes by the task notice; record `fs131-w8c`'s `plans/FS131-I8C-implementation.md`; report `data/fs131/reports/FS131-I8C.md`; commits `7e236096`, `1e605b60`, `b0699c54`, `0bdf6ea9`; pushed, tree clean).
> — source: plans/FS131-close-inventory.md

> 598. **FS131-I8D done: wave 8's `SemiHubPlaces` and `outerAdj` — all seven leaves proved; with its sibling's branch the wave's line holds no open leaf** (implementer, Opus; harness 590k and 58 minutes by the task notice; record `fs131-w8d`'s `plans/FS131-I8D-implementation.md`; report `data/fs131/reports/FS131-I8D.md`; commits `46ba22e6`, `7376b9b7`, `1e6b71d9`, `989a0393`; pushed, tree clean).
> — source: plans/FS131-close-inventory.md

> 591. **FS131-LT5 done: the gate's step that lists what the library assumes is on `main` — of 10,173 theorems, 58 are conditional on something the kernel did not check** (landing implementer, Opus; harness 560k and 120 minutes by the task notice; record `plans/FS131-LT5-landing.md`; report `data/fs131/reports/FS131-LT5.md`; gated commit `5a62be0a`, landed `befb51d3`, a fast-forward).
> — source: plans/FS131-close-inventory.md

## The statements

No statement, definition or proof changes in this job. Heads of the wave, as they stand on the two branches — after the join each must
print the standard three and nothing else (read each whole):

> theorem emptyNS {F : ArcMap 6} (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8d/Proofs/HadwigerNelson/Plane/RingCalculus/Empty.lean

> theorem outerAdj {F : ArcMap 6} (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8d/Proofs/HadwigerNelson/Plane/RingCalculus/Empty.lean

> theorem star_anti {F : ArcMap 6} (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8l/Proofs/HadwigerNelson/Plane/RingCalculus/Star.lean

> theorem ringArc_star (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hpd : p ∈ F.dom) (hS : F.SimpleOn {p})
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8l/Proofs/HadwigerNelson/Plane/RingCalculus/SemiHub.lean

> theorem semiHub_places (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1) {ψ : ℝ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8d/Proofs/HadwigerNelson/Plane/RingCalculus/SemiHubPlaces.lean

The gate's recorded state on `main`, which your counts are reconciled against, and the line every landing carries since the gate's
newest step landed:

> as a set); the current audit reads 6304 clean and 5 declared purchases, and 8 imported (and 17 axiom-free; 6,334 records at wave 10's second
> — source: CLAUDE.md § Trust ledger

> **What the library assumes, in both forms** (`scripts/assumptions.sh`, whose digest reads these counts and fails if
> — source: CLAUDE.md § Trust ledger

> `declarations=14501 refutations-skipped=199 sites=1269`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1226 unknown=2`.
> — source: CLAUDE.md § The gate

> > A wave that brings an assumption in hypothesis form — a named `Prop` standing for an outside theorem, a hand result
> — source: plans/FS131-LT5-landing.md

## Done means

1. **Your readback first**: check every quotation above against its source; read the two parallel implementers' reports and the last
   sections of their records ("for the join", their drafts — on your branch `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8l/plans/FS131-I8C-implementation.md`; on the other,
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8d/plans/FS131-I8D-implementation.md`), the join job's and the first implementer's records on your branch, the planners' record
   (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8l/plans/FS131-w8-kernel-plan.md`), `LEAN.md` § The gate and § Assumptions as they stand on `main` today (they changed this
   afternoon: read them on `main`, not on your branch), and the last landing's record for the gate's procedure with its newest step
   (`/home/kooshi/source/lean-dir/plans/FS131-LT5-landing.md`). Build the branch once as given (seven `sorry`: six in `SemiHubPlaces`, one in `Empty` —
   each proved on the branch you are about to merge). Open your record. Commit and push.
2. **The join**: `git merge origin/fs131-w8d` (at `989a0393`), its own commit. My trial conflicts in `ARCHITECTURE.md` and
   `scripts/Axioms.lean` only — adjacent additions, keep every side; a conflict in a Lean file is a message to me. Committed as a
   merge, the index holding the merge and nothing else. Build. **The receipt that the wave is whole**: zero `sorry` under `Proofs/`;
   every declaration the five implementers' reports name — their clean records and every one they list as resting on the other
   branch's leaves — on exactly the standard three or a subset, with a control that fires; no statement of either side changed by
   the merge (by script, on elaborated signatures: the wave's tools are in `tools/` on your branch).
3. **`main` merged in** (at `d4fb9390` when this was written): this line last had `main` before wave 5 landed. Trial it first and
   name the conflicts before you make it (my trial: `ARCHITECTURE.md`, `Proofs.lean`, `scripts/Axioms.lean` — adjacency, keep every
   side). A conflict in a Lean file under `Proofs/` is a message to me. Build.
4. **The docstring corrections, and nothing else in the modules** (each shown by script to touch no line outside a doc comment):
   the sentence of `fullSemiHub_star_crossed`'s docstring that says four colours follow from `germS_absent` (they do only at six
   colours: inventory item 592); the five statements ruled there say "inventory item 592" where they say "ruled on FS131-I8D's
   finding"; `SemiHub`'s line of prose that holds the word `sorry`; `ARCHITECTURE.md`'s row for `StarChart`, which still says no
   module imports it. **Not made, by ruling 598 (b)–(c)**: no row is restated at its wider class, and `Empty` keeps its import of
   `SemiHub` through `OuterAdj`.
5. **Every head's statement, read from the kernel** (inventory item 556): for every theorem the wave's records name as a head, the
   stored type's binders against its file's signature and the section variables in scope — the last landing's instrument does this
   for a list of modules (`tools/fs131_l10b_kernelsig.py` with `data/fs131/l10b/kernel-sigs.lean`, on `main`). A hypothesis missing
   from a kernel statement is a message to me with the head's name.
6. **What the wave assumes, declared** (the line quoted above; the procedure is `LEAN.md` § Assumptions on `main`): run
   `./scripts/assumptions.sh --self-test`, then `./scripts/assumptions.sh`, and read every failure before you declare anything. For
   each: an assumption (with its kind and a source that is a bibliography key, a ledger row or a derivation entry's id), or a
   condition with its reason — decided from the definition's docstring and the planners' records, never from the name. This wave's
   planners expected no named hypothesis (one was planned and found unnecessary: item 571); if the step finds one no record
   explains, that is a message to me. Then `--write-ledger`, every row it gains or loses read and listed.
7. **The full gate on one commit**: `./scripts/build.sh` with zero warnings (count them); zero `sorry` in `Proofs/`; the
   doubled-name check after the build and before the axiom audit — `/home/kooshi/source/lean-dir/scripts/slot.py --mem 16 --cpus 8
   -- ./scripts/dupnames.sh`, then its `--self-test` under `--mem 4 --cpus 4`; `scripts/axioms.sh` clean, every record of the wave
   registered and within the standard three, `--self-test` green; `scripts/vacuity.sh` and `--self-test` green, the counts
   reconciled against the line above — this wave brings refutations and theorems whose hypotheses no Lean object is yet known to
   meet (a star, a semi-hub, two adjacent change points, a nine-colour model for `emptyNS`: each owed, and said so in its
   docstring): say how the scan classes every new site, and a site read as vacuous or unknown, or a request for a baseline entry, is
   a message to me with the scan's line; `./scripts/assumptions.sh` and its `--self-test` green (the nine counts on the front page
   will read stale until I refile them: flagged, not failed); `tools/check_architecture.py` exit 0; the guarded lint,
   `lake lint --no-build -- --no-build --trace` under the slot with `--mem 8`, silent; the notes check by its working-tree wrapper,
   `tools/fs131_l5_notes.py`, no CONFLICT; the records check (`tools/fs131_l10b_records.py`, as the last landing ran it). Save every
   step's log under `data/fs131/l8a/` and name them.
8. **The landing**: if `main` moved meanwhile, merge it again; when the new commits touch only `plans/`, `data/`, `.claude/`,
   `BIBLIOGRAPHY.md`, `LEDGER.md`, `LEAN.md`, `RUNNING.md`, say so with the diff that shows it, otherwise re-run the gate on the
   merged commit. Then `git push origin HEAD:main` from the worktree — a fast-forward only, never a force-push; on a rejected push,
   fetch, merge and try again.
9. **Drafts for the filing**, in your record under "Drafts for the front page (FS131-L8A)", each with the log line it comes from: the
   `CLAUDE.md` § Trust ledger sentence's counts and its nine assumption counts; § The gate's two count lines; a `GATE_CHANGES` entry
   for `tools/claude_md_fact_audit.py` (the previous landing's receipts are `data/fs131/lt5/gate/receipt-axioms-landed2.log`,
   `data/fs131/lt5/gate/receipt-vacuity-landed2.log` and `data/fs131/lt5/gate/receipt-assumptions-landed2.log`); the five implementers' and two planners'
   drafts gathered and corrected for what the join changed (`LEDGER.md` regrades — FS116-V5-QCOL's with "all clauses but the one
   never stated"; `plans/LEAN-BACKLOG.md` rows; the errata for the rows the wave found wider or narrower than filed, each with the
   Lean name that shows it); **the open gate items at this landing**, by name; and what a third planning pass still has to state
   (two rows and one clause).
10. **Your record**, stages headed "Stage n — SAVED (FS131-L8A)"; the report in standing rule 11's form, the wave's heads and record
    counts read from the gate's saved logs. Leave no background process running. Stopping at a saved stage with the gate red at a
    named check is a good report — say which check, its log, and what you would try next.

## What is yours to decide

The order inside each step, how the registry files are resolved, how the vacuity scan's new sites and the assumptions step's
failures are handled under their own procedures, and whether a docstring correction is deferred (say which, and why). If the join
shows something no job could see from its branch — a declaration still on `sorryAx`, a statement the two branches hold differently, a
name both declared — that is a finding, and the first of those is the one this job exists to look for: fix what is within your
touches and ruled, and message me for the rest. Do not weaken a check to pass it. Three failed attempts on one route is a dispatch
to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.
