# Brief FS131-I10B — wave 10, the stationary ratio: the open leaves of one file of the arithmetic wave, on `fs131-w10b`

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I10B
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: one of wave 10's three implementers, split by file — prove the open leaves of `Proofs/HadwigerNelson/Arith/StationaryRatio.lean` (three leaves) from the planner's plan, without changing a statement, saving after each group
  launch: when a slot frees, beside the wave's other implementers on branches of their own and jobs of other waves
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf whose statement is false or cannot be proved as stated (at once, with the reason: a statement change goes back through me), a classical input the plan names as a hypothesis that you find you can formalize in about an hour (say so and do it) or that needs more than its named form, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I10B.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I10B-implementation.md` (new, on branch `fs131-w10b`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10b` (branch `fs131-w10b`, from the planner's `f919973e`): `Proofs/HadwigerNelson/Arith/StationaryRatio.lean` (three leaves); new helpers as new declarations in your own file, under names no other module declares (`LEAN.md` § Searching — Lean, last bullet: two branches never state one lemma under one name; the wave's other files are other implementers'); `scripts/Axioms.lean` (a block of your own, headed "FS131-I10B", above the `=== PURCHASED ===` banner), `plans/FS131-I10B-implementation.md`, `tools/fs131_i10b_*.py`, `data/fs131/i10b/`, `data/fs131/reports/FS131-I10B.md`; **not** the wave's other files, any landed module beyond new declarations, `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are proving one file of the arithmetic wave of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–5 are on `main`. Wave 10 is fourteen arithmetic rows — the character colouring, the spectral inputs under the
five-colour proof at `ℚ(√47)`, the stationary ratio, a degree-28 field — and it depends on nothing in the plane's waves. Its planner read every
row against its derivation, found one filed statement that hid a hypothesis and one whose "every" was three, proved four rows on the way, and
left a skeleton with a plan per leaf. Three implementers take the leaves, one file each. This file is yours.

## Why this job

A result counts as held only when its Lean module passes the gate. These rows are the arithmetic era's last hand results; Mathlib has none of
their spectral side, so the classical inputs are named hypotheses, each documented — and each one you can replace by a proof is a smaller
assumption at publication. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

The plan's hand-back and the rulings in force:

> 484. **FS131-K10 done at its Stage 5: wave 10 planned — dispositions for all fourteen rows, a foundation, a skeleton of eleven, four rows
> — source: plans/FS131-close-inventory.md

> 485. **Rulings on K10's held items, and its slot.** (a) **Three implementers by file, as it splits them**; the first, FS131-I10A
> — source: plans/FS131-close-inventory.md

> 477. **FS131-K10, by message at its Stage 1 (`fs131-w10` at `6ca3fb4e`): a statement defect in a filed hand result, a gap, a generalization**
> — source: plans/FS131-close-inventory.md

> 478. **Rulings on item 477** (sent to K10 by message). (a) **TC1-STANDING-FIVE takes a second named hypothesis beside `Row123Chain`, the
> — source: plans/FS131-close-inventory.md

The first implementer's hand-back — its record (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10/plans/FS131-I10A-implementation.md`, on
branch `fs131-w10`, not merged into yours) has Lean facts met on the way that may save you time: a notation that parses against the eye, an
action whose `T 0` need not be the identity, a route that fails at an atom:

> 493. **FS131-I10A done: all nine leaves of wave 10's first file pair proved — `SpectralInputs` and `CharacterColouring` hold no `sorry`, over
> — source: plans/FS131-close-inventory.md
## The statements

No statement changes in this job. The plan's section for your file (read the whole record: § 2 the dispositions, § 3 the foundation, § 5 the plan
per leaf with the named hypotheses' four items in § 5.5), and every leaf's docstring in the file, which states its route:

> ### 5.3 `StationaryRatio` — three leaves
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10b/plans/FS131-w10-kernel-plan.md

> ### 5.5 The named hypotheses, with `LEAN.md` § Assumptions' four items, and what each would take
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10b/plans/FS131-w10-kernel-plan.md

## Done means

1. **Your readback first**: check the quotations against their sources; read the planner's record whole, your file, the foundation it rests on,
   and each row's derivation entry at the address the record gives. Build the branch once as given (21 `sorry` leaves over the four files) — your tree's build was copied from an idle tree on `main`'s line that predates the wave's four modules, so this first build compiles them: let it, and say what it rebuilt. Open
   your record with what you may and may not change. Commit and push.
2. **The leaves**, in the plan's order, saving after each group (a build, the axioms print for the group with a control that fires, a statement
   check against `f919973e`, commit, push). Re-price after your first two leaves and say so.
3. No statement or definition changed; no new `axiom`, no `native_decide` (a certified computation follows `LEAN.md` § The kernel's cost model).
   A named hypothesis stays a hypothesis unless you prove it. Do not edit a file while a build of it runs. You do not merge another branch,
   run the gate, or touch `main`. Leave no background process running, and keep what your record cites under your `data/` folder.
4. **Your record**, stages headed "Stage n — SAVED (FS131-I10B)", "Theorems this phase proved", each read against its row; the report in standing rule
   11's form, ending with what is left and its route. Stopping at a saved stage with part of the leaves proved is a good report.

## What is yours to decide

The route inside each leaf, your helpers, and the order within the plan's dependencies. The planner's routes are one mind's, some marked as not
yet confirmed by a proof; change one that does not go and say so. A leaf's statement is not yours to change: one that is false or too weak is a
message to me, and a finding. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.
