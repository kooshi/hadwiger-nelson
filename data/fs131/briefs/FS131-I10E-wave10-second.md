# Brief FS131-I10E — wave 10, the target at 128 needs eight colours — the bridge from a kernel-checked certificate to the character sums of the norm-one target, with no outside theorem: open leaves of the second planning pass, on `fs131-w10e`

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I10E
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: one of three implementers of wave 10's second planning pass, split by file — prove the open leaves of `Proofs/HadwigerNelson/Arith/Floor128.lean` (one leaf, `charSum_128_ge`, with the six children the plan names) from the planner's plan, without changing a statement, saving after each leaf or group
  launch: when a slot frees, on a branch cut from the commit at which the wave's second planner handed back, beside the wave's other implementers on branches of their own
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf whose statement is false or cannot be proved as stated (at once, with the reason: a statement change goes back through me), a step of a hand argument that fails or does not formalize (with its address), a certificate or tool that disagrees with the kernel, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I10E.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I10E-implementation.md` (new, on branch `fs131-w10e`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10e` (branch `fs131-w10e`, cut from `fs131-w10k` at `330d2f48`): `Proofs/HadwigerNelson/Arith/Floor128.lean` (one leaf, `charSum_128_ge`, with the six children the plan names) — proofs, and new helper declarations under names no other module declares (`LEAN.md` § Searching — Lean, last bullet: two branches never state one lemma under one name); `scripts/Axioms.lean` (a block of your own, headed "FS131-I10E", above the `=== PURCHASED ===` banner), `plans/FS131-I10E-implementation.md`, `tools/fs131_i10e_*.py`, `data/fs131/i10e/`, `data/fs131/reports/FS131-I10E.md`; **not** the wave's other files (the other implementers', and the four first-pass files, which wait for the join), the planner's record, any landed module beyond new declarations, `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are proving part of the arithmetic wave of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–5 are on `main`. Wave 10 is fourteen arithmetic rows; three of its four first files are proved on their own
branches, and its second planner has just stated what the first pass left: the *finite-target floor* — certain finite graphs need seven
colours, a hand result a degree-28 field's theorem leans on — as two rows, and three short leaves beside it. This part is yours:
the target at 128 needs eight colours — the bridge from a kernel-checked certificate to the character sums of the norm-one target, with no outside theorem.

## Why this job

A result counts as held only when its Lean module passes the gate. Until these leaves are proved the wave's standing-five theorem rests on a
floor nobody has put in the kernel, and one of its theorems has no Lean model of its hypotheses. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

What the planner handed back and the rulings in force (read each item whole in the inventory):

> 509. **FS131-K10b done at its Stage 9: wave 10's second planning pass — the finite-target floor stated as two rows, the read-backs
> — source: plans/FS131-close-inventory.md

> 510. **Rulings on K10b's held items, and its slot.** (a) **Three implementers by file, as it splits them**, on branches cut from
> — source: plans/FS131-close-inventory.md

> 500. **FS131-K10b, by message mid-job, before stating the floor's import: the bound for the circle sums is a theorem of the held
> — source: plans/FS131-close-inventory.md

> 503. **FS131-K10b, by message mid-job: J45-SI-J holds at a wider class by a shorter route — no spectral measure, no "Bernoulli has
> — source: plans/FS131-close-inventory.md

## The statements

No statement changes in this job. Your leaves, as they stand in your tree (read each whole, with its docstring):

> theorem charSum_128_ge {k : Type} [Field k] [Fintype k] [DecidableEq k] (hcard : Fintype.card k = 128 ^ 2)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10e/Proofs/HadwigerNelson/Arith/Floor128.lean

> theorem targetFloor_eight_128 : TargetFloor 8 128 :=
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10e/Proofs/HadwigerNelson/Arith/Floor128.lean

The plan (the planner's record, `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10e/plans/FS131-w10-kernel-plan.md`: read Stages 6–9 whole;
the sections for your files give a route, the Mathlib names it confirmed with `#check`, what is hard, and a price per child):

> ### 7.2 Row (i) — the target at 128, no outside theorem: `Floor128.targetFloor_eight_128 : TargetFloor 8 128`
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10e/plans/FS131-w10-kernel-plan.md

> ### 7.1 The ratio bound — where it lives, and its class
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10e/plans/FS131-w10-kernel-plan.md

> ### 9.3 Prices (re-priced from this pass's proved leaves: the ratio bound, 170 lines in two rounds; `GapSeven`, eight facts in one)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10e/plans/FS131-w10-kernel-plan.md

> ### 9.4 For the joining job
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10e/plans/FS131-w10-kernel-plan.md

## Done means

1. **Your readback first**: check the quotations against their sources; read the planner's record (Stages 6–9; Stages 2–5 as far as your
   files rest on the first pass's), your files and the modules they import, and each row's derivation entry at the address the record gives.
   Build the branch once as given (23 `sorry` leaves on the branch: one yours). Open your record with what you may and may not change. Commit and push.
2. **The leaves**, in this order — the plan's children for `charSum_128_ge`, in its order; saving after each leaf or group (a build, the axioms print for it with a control that fires,
   a statement check against `330d2f48`, commit, push). Re-price after your first two leaves or children and say so: the wave's first two
   implementers each came in at a third to two thirds of the planner's line count.
3. **The certificate is already kernel-checked** (`order_checks`, `counts_ok` by `decide +kernel`; the planner measured 2.3 s): your leaf is the mathematics between it and the statement — an explicit model of the field with `128²` elements, its generator, the norm-one group, and every non-trivial character's sum read off the counts. The spectrum itself (−19 … 21) is [tools, exact, two routes] (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10e/tools/fs131_k10b_u128.py` and `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10e/tools/fs131_k10b_gen128.py`, on your branch): if a `decide` of yours disagrees with either tool, stop and report. Any new certified computation follows `LEAN.md` § The kernel's cost model — measure before you commit to a shape; no `native_decide`.
4. No statement or definition changed; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not merge
   another branch, run the gate, or touch `main`. Leave no background process running, and keep what your record cites under your `data/`
   folder.
5. **Your record**, stages headed "Stage n — SAVED (FS131-I10E)", "Theorems this phase proved", each read against its row; the report in standing
   rule 11's form, ending with what is left and its route. Stopping at a saved stage with part of the leaves proved is a good report.

## What is yours to decide

The route inside each leaf, your helpers, and the order within the plan's dependencies. The plan is one mind's, written today and compiled
only as far as its statements; change a route that does not go and say so. A statement is not yours to change: one that is false, or true
only with a hypothesis the plan did not see, is a message to me, and a finding. Three failed attempts on one route is a dispatch to the
companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.

## Amendment 1 (2026-10-06, at launch) — your branch now holds the planes' floor, proved

Nothing above is withdrawn; three facts changed.

1. **Your branch was fast-forwarded** from `330d2f48` to `a14f9ab0`, the hand-back of the implementer of `NormOneTarget` and `FloorPlanes`
   (FS131-I10D, inventory item 538) — your tree was untouched, so nothing of yours moved, and your one file is byte-identical. Your
   statement check is against `a14f9ab0`; the branch as given now has seventeen `sorry` leaves, one yours. The first build recompiles
   those two modules and what imports them.
2. **Two of the children the plan names for `charSum_128_ge` are now theorems in your tree — cite them, declare neither again**: "every
   non-trivial additive character is a shift of one" and the count of the norm-one set, which at `Q = 128` is the number of solutions of
   `u ^ 129 = 1`:

> theorem exists_mulShift_eq {F : Type*} [Field F] [Finite F] (ψ₀ : AddChar F ℂ) (hψ₀ : ψ₀ ≠ 1) (φ : AddChar F ℂ) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10e/Proofs/HadwigerNelson/Arith/FloorPlanes.lean

> theorem card_normOne {k : Type*} [Field k] [Fintype k] [DecidableEq k] {Q : ℕ} (hcard : Fintype.card k = Q ^ 2) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10e/Proofs/HadwigerNelson/Arith/NormOneTarget.lean

> theorem card_filter_pow_eq_one {k : Type*} [Field k] [Fintype k] [DecidableEq k] {d : ℕ} (hd0 : d ≠ 0)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10e/Proofs/HadwigerNelson/Arith/NormOneTarget.lean

   If one does not fit your leaf as stated (its binders, its field), write a corollary under a name of your own and say so in your report.
3. **A lesson from today, for your mid-job messages** (inventory item 526): when you report a defect, say which kind it is — a
   *statement* that needs a hypothesis it lacks, or a *route* that reads more than the statement needs (a shorter-route note, no defect).
