# Brief FS131-L6A — wave 6's first landing: the five proved branches joined, the ruled tidies, `main` merged, the full gate on one commit, and `main` fast-forwarded

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-L6A
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the landing implementer of wave 6's first two planning passes — merge the implementers' branches into one line, make the short list of ruled tidies, merge `main`, run the full gate on one commit with its newer steps, fast-forward `main`, and draft the counts and the front-page lines for the filing
  launch: when a slot frees, in a tree of its own cut from the last implementer's tip; other jobs work on other waves and on this wave's later modules in trees of their own, and commit nothing to `main` but `plans/` and `data/`
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a merge conflict beyond the kinds named below, a gate step red for a reason you cannot repair within your touches (the vacuity scan reading a new site as vacuous or unknown, an axiom record outside the standard three, a name declared twice), a ruled tidy that does not go through as ruled, a declaration that still prints `sorryAx` after the join (at once: it means a leaf thought proved on another branch is not, or its statement differs), a statement that differs between two branches, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-L6A.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-L6A-landing.md` (new, on branch `fs131-w6j`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6j` (branch `fs131-w6j`, cut from `fs131-w6g` at `b3b67f23`): the merges' files; the fourteen modules under `Proofs/HadwigerNelson/Plane/Saturated/` that the wave's first two planning passes and their five implementers wrote, for the ruled tidies and their docstring lines only; `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`; the vacuity scan's files where its own procedure sends you (`scripts/Vacuity.lean`, `scripts/vacuity-controls.lean`, `scripts/vacuity.sh`, `scripts/vacuity-baseline.txt` — the last only on my word); `plans/FS131-L6A-landing.md`, `tools/fs131_l6a_*.py`, `data/fs131/l6a/`, `data/fs131/reports/FS131-L6A.md`; `main` by the one fast-forward push this brief names; **not** any statement but the ruled ones, any landed module beyond what a merge brings, the wave's four later modules (`CoverHull`, `Parallel`, `Centre`, `Accumulation` are on another branch and are not part of this landing), `CLAUDE.md`, `LEDGER.md`, `LEAN.md`
  budget: about 450k by the harness's count, as guidance; hand back at a saved stage before about 550k — read your token count at every saved stage

Hello. You are landing the first half of wave 6 of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–5, a library of example maps and wave 10's first files are on `main`. Wave 6 is thirty-five rows about
*saturated* colourings — classes carved by unit circles about their own points. Its first two planners stated twelve of them, with a
deriver's new theorem between: that a saturated colouring whose singular set is locally finite has, at each singular point, finitely many
boundary curves leaving it in definite directions (a *fan*). Five implementers have since proved every leaf of those statements — each on
a branch of its own, and most of their theorems rest on leaves another of them proved. No tree has ever held all of it at once. You make
them one line, and the kernel checks the whole chain for the first time.

## Why this job

A wave counts as held only when its declarations pass the full gate on one commit (the milestone's announcement rule,
`plans/FS131-close-inventory.md`); nothing with a `sorry` reaches `main`. Until the join, "proved" for most of this wave means proved over
a leaf proved elsewhere under the same statement — forty-six audit records print `sorryAx` on their own branches for that reason alone.
This job is where that either becomes a kernel fact or shows a seam. Kooshi, on what the evidence must be:

> - **The artifact is the certificate plus the checker, never the search.** Commit the data a reviewer re-checks; never require them to
> — source: CLAUDE.md § The standard of evidence above rung B

The five implementers' hand-backs, the planners' and the deriver's, and the rulings in force (read each whole in the inventory):

> 516. **FS131-I6A done: all seven leaves of wave 6's `Pinch` proved as stated — the pinch, its impossible case, the two tangent
> — source: plans/FS131-close-inventory.md

> 517. **Rulings on I6A's held items, and its slot.** (a) **The weaker (H2) is offered to the wave's third planner, not adopted
> — source: plans/FS131-close-inventory.md

> 530. **FS131-I6B done: `sat_inP` proved (FS121-C1-SAT), at a wider class than filed, with its Lean model — the nine-colour grid as
> — source: plans/FS131-close-inventory.md

> 539. **FS131-I6C done: `Curve` and `LocalGraph` are proved — all eleven leaves, as stated; the local graph theorem of the
> — source: plans/FS131-close-inventory.md

> 540. **FS131-I6D done: the existence half of the bridge is proved — all seven leaves, as stated — so the deriver's theorem "a
> — source: plans/FS131-close-inventory.md

> 544. **FS131-I6E done: `FanBridge`'s five lemmas about any fan are proved, as stated — with the three cell lemmas of a fan as
> — source: plans/FS131-close-inventory.md

> 491. **FS131-E8 done: nine entries derived, none stalled — the bridge (item 490, its §§ 3.1–3.7 unchanged since), the consumers traced row by
> — source: plans/FS131-close-inventory.md

> 492. **Rulings on E8's held items, and its slot.** (a) **REG-J′ and C121-REGJ keep their frozen words in the stubs' question sections and
> — source: plans/FS131-close-inventory.md

> 535. **FS131-L10A done: wave 10's first pass is on `main` through the full gate — `c70a1cf8..002c921a`, a fast-forward; gated
> — source: plans/FS131-close-inventory.md

## The statements

No statement changes in this job. Heads of the five branches, as they stand there — after the join each must print the standard three and
nothing else (read each whole):

> theorem pinch {A B N : Set ℂ} (hA : MeasurableSet A) (hAn : UnitPairsNull A) (hB : MeasurableSet B)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6p/Proofs/HadwigerNelson/Plane/Saturated/Pinch.lean

> theorem sat_inP (F : ArcMap k) (hF : F.IsPlaneMap) (c : AeColouring k)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6m/Proofs/HadwigerNelson/Plane/Saturated/MapColouring.lean

> theorem local_graph {A B N : Set ℂ} (hA : MeasurableSet A) (hAn : UnitPairsNull A) (hB : MeasurableSet B)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6j/Proofs/HadwigerNelson/Plane/Saturated/LocalGraph.lean

> theorem fan_of_isolated (c : AeColouring k) {z : ℂ} {R : ℝ} (hR : 0 < R) (hS : c.singularSet ∩ ball z R ⊆ {z})
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6f/Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean

> theorem regJFan_of_saturated (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite) : c.RegJFan :=
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6f/Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean

> theorem sector_alone (hsat : SaturatedOn c.cls (ball z F.r \ {z})) {i i' : Fin F.n} (hi : F.dir i < F.nextDir i)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6j/Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean

The gate's recorded state on `main`, which your counts are reconciled against:

> `declarations=13767 refutations-skipped=192 sites=1173`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1130 unknown=2`.
> — source: CLAUDE.md § The gate

## Done means

1. **Your readback first**: check every quotation above against its source; read the five implementers' reports and the last sections of
   their records ("what the join must know", their drafts) — on your branch
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6j/plans/FS131-I6E-implementation.md` and
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6j/plans/FS131-I6C-implementation.md`, and on theirs `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6f/plans/FS131-I6D-implementation.md`,
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6p/plans/FS131-I6A-implementation.md`,
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6m/plans/FS131-I6B-implementation.md` — the planners' record
   (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6j/plans/FS131-w6-kernel-plan.md`, Stages 1–12), and the last landing's record
   for the gate's procedure (`/home/kooshi/source/lean-dir/plans/FS131-L10A-landing.md`, Stages 4–6). Build the branch once as given
   (fifteen `sorry` leaves: seven in `FanBridge`, seven in `Pinch`, one in `MapColouring` — each proved on a branch you are about to
   merge). Open your record. Commit and push.
2. **The merges**, each its own commit, each checked before the next: `git merge origin/fs131-w6f` (at `8e81fedd`: the other half of
   `FanBridge` and four new modules), then `origin/fs131-w6p` (at `43ea4886`: `Pinch`), then `origin/fs131-w6m` (at `2e55a2d6`: `MapColouring`,
   `MapEdge`, `Sq9Map`); your branch already holds `origin/fs131-w6c` (`d62406a2`). A trial of each on this tree's tip shows conflicts in
   `ARCHITECTURE.md` and `scripts/Axioms.lean` only — adjacent additions: keep every side — and **none in a Lean file, the two halves of
   the module both implementers of the bridge wrote in included**; trial each yourself before you make it, and a conflict in a Lean file is a message to me. A merge is
   committed as a merge, the index holding the merge and nothing else, checked. Build. **The receipt that the first half is whole**:
   zero `sorry` under `Proofs/HadwigerNelson/Plane/Saturated/`; every declaration the five reports name — their clean records and every one they list as wired or resting
   on an upstream leaf — on exactly the standard three or a subset, with a control that fires; no statement of any side changed by the
   merges (by script, against each branch's tip).
3. **The ruled tidies**, each checked by script to be exactly what is ruled: (i) the fifth implementer's `polarRegion_isOpen` and
   `polarRegion_isPreconnected` are deleted in favour of the fourth's `isOpen_polarRegion` and `isPreconnected_polarRegion` — the same
   statements binder for binder — and their three uses repointed (its record, Stage 6); (ii) the audit records the reports leave for the
   join are appended to their blocks of `scripts/Axioms.lean` — the third implementer's six, the fifth's fourteen — and the fourth's block
   re-read now that nothing beneath it is open; (iii) docstring sentences that the join makes false are corrected, base text otherwise
   intact: the three "[hand], one mind, until … lands" phrases the fourth implementer lists, the module docstrings that say "skeleton" or
   "kernel pending", `ARCHITECTURE.md`'s rows for the fourteen modules; (iv) **nothing else**: `SeparatesAt` keeps its second clause
   (ruling 544 (c)); the hypotheses the implementers found unread stay in their statements (rulings 419 (c), 539 (a)); `fanAngle` beside
   `polarAngle` and `MapEdge`'s restated puncture lemma are left for a tidy after the landing (ruling 544 (d)) — `./scripts/dupnames.sh`
   passes because their names differ, and your drafts list them.
4. **`main` merged in**: this line last had `main` before the example maps and wave 10's first files landed. Trial it first and name the
   conflicts before you make it (a trial shows `ARCHITECTURE.md`, `Proofs.lean`, `scripts/Axioms.lean`: adjacency, keep-both). A conflict
   in a Lean file under `Proofs/` is a message to me.
5. **The full gate on one commit**: `./scripts/build.sh` with zero warnings (count them); zero `sorry` in `Proofs/`;
   **the doubled-name check on the joined tree, after the build and before the axiom audit** —
   `/home/kooshi/source/lean-dir/scripts/slot.py --mem 16 --cpus 8 -- ./scripts/dupnames.sh`, then its `--self-test` under `--mem 4 --cpus 4`
   (with a doubled theorem name an axioms print can be clean over a `sorry` copy); `scripts/axioms.sh` clean, every record of the wave
   registered and within the standard three, `--self-test` green (controls' expected counts fixed where your state moves them, each shown
   red before and green after); `scripts/vacuity.sh` and `--self-test` green, the counts reconciled against the line above — this wave
   brings new structures and predicates (`Fan`, `IsInterfaceChart`, `IsUnitCurve`, `TwoColourOn`, and the fourth implementer's
   `HasArcChart`, `ArcSetting`, `IsArcOf`, whose inhabitant it names): follow the scan's own procedure for which are tracked, say how the
   scan classes every new site, and a new site read as vacuous or unknown, or a request for a baseline entry, is a message to me with
   the scan's line; `tools/check_architecture.py` exit 0; **the guarded lint**, `lake lint --no-build -- --no-build --trace` under the
   slot with `--mem 8` (`LEAN.md` § The gate), silent; **the notes check**, `tools/fs131_qa4_notes.py`, no CONFLICT; **the records
   check** against the kernel's own list of theorems (`tools/fs131_l5_records.py`, as the last three landings ran it: every hand-written
   theorem of the wave has one record, on exactly the standard three or a subset). Save every step's log under `data/fs131/l6a/` and name
   them.
6. **The landing**: if `main` moved meanwhile, merge it again; when the new commits touch only `plans/`, `data/`, `.claude/`,
   `BIBLIOGRAPHY.md`, `LEDGER.md`, `LEAN.md`, say so with the diff that shows it, otherwise re-run the gate on the merged commit. Then
   `git push origin HEAD:main` from the worktree — a fast-forward only, never a force-push; on a rejected push, fetch, merge and try again.
7. **Drafts for the filing**, in your record under "Drafts for the front page (FS131-L6A)", each with the log line it comes from: the
   `CLAUDE.md` § Trust ledger sentence's counts; § The gate's two count lines; a `GATE_CHANGES` entry for `tools/claude_md_fact_audit.py`
   (the previous landing's receipts are `data/fs131/l10a/receipt-axioms-first.log` and `data/fs131/l10a/receipt-vacuity-first.log`); the
   implementers' and the deriver's drafts gathered and corrected for what the join changed (`plans/LEAN-BACKLOG.md` rows, `LEDGER.md`
   clauses, the grade lines of the deriver's entries); **the named hypotheses each landed theorem rests on, by name**, if any; **the open
   gate items at this landing** (a theorem whose hypotheses no Lean object on `main` satisfies at once — the planners' records name the
   classes whose satisfiability is open, and those say so in their docstrings); the generalizations the five reports found, as a list for
   the wave's errata; and the two tidy moves of item 3 (iv). **One draft is the front page's**: with the bridge in the kernel, the
   regularity hypothesis this project calls REG-J′ can be said as "the singular set is locally finite" (ruling 492 (a); the deriver's
   texts are in `plans/FS131-E8-derivation.md` §§ 4.4, 4.6) — draft the sentences that change, each with the Lean theorem that licenses
   it, and say plainly what the kernel holds and what it does not (the rows of the third planning pass are not landed).
8. **Your record**, stages headed "Stage n — SAVED (FS131-L6A)"; the report in standing rule 11's form, the wave's heads and record counts
   read from the gate's saved axioms log. Leave no background process running. Stopping at a saved stage with the gate red at a named
   check is a good report — say which check, its log, and what you would try next.

## What is yours to decide

The order of the merges and inside each step, how to resolve keep-both conflicts, how the vacuity scan's new sites are registered under
its own procedure, and whether a tidy of item 3 is deferred. If the join shows something no job could see from its branch — a declaration
still on `sorryAx`, a statement two branches hold differently, a record the audit reads differently on the joined line, a name two
branches both declared — that is a finding, and the first of those is the one this job exists to look for: fix what is within your
touches and ruled, and message me for the rest. Do not weaken a check to pass it. Three failed attempts on one route is a dispatch to the
companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.
