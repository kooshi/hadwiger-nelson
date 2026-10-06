# Brief FS131-I6A — wave 6, the pinch at a two-colour point and its first consequences: the open leaves of `Pinch`, on `fs131-w6p`

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I6A
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: one of wave 6's first two implementers, split by file — prove the open leaves of `Proofs/HadwigerNelson/Plane/Saturated/Pinch.lean` (seven leaves: `pinch_not_in_in`, `pinch`, `TwoColourOn.essBoundary_inter_eq`, `c11_discs`, `c11_split`, `half_upperDensity`, `sq9_isTangentAt`) from the planners' plans, without changing a statement, saving after each leaf or group
  launch: when a slot frees, on a branch cut from the commit at which the wave's second planner fixed these statements; that planner (FS131-K6b) is still working on `fs131-w6`, adding modules downstream of yours
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf whose statement is false or cannot be proved as stated (at once, with the configuration: a statement change goes back through me, and the planner is building on these statements now), a definition in `Basic` you need changed or a lemma you need exported from it, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I6A.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I6A-implementation.md` (new, on branch `fs131-w6p`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6p` (branch `fs131-w6p`, cut from `fs131-w6` at `3928644b`): `Proofs/HadwigerNelson/Plane/Saturated/Pinch.lean` (seven leaves: `pinch_not_in_in`, `pinch`, `TwoColourOn.essBoundary_inter_eq`, `c11_discs`, `c11_split`, `half_upperDensity`, `sq9_isTangentAt`) — proofs, and new helper declarations under names no other module declares (`LEAN.md` § Searching — Lean, last bullet: two branches never state one lemma under one name); a new module of your own beside it if the helpers want one, with `Proofs.lean` and `ARCHITECTURE.md` for it; `scripts/Axioms.lean` (a block of your own, headed "FS131-I6A", above the `=== PURCHASED ===` banner), `plans/FS131-I6A-implementation.md`, `tools/fs131_i6a_*.py`, `data/fs131/i6a/`, `data/fs131/reports/FS131-I6A.md`; **not** `Proofs/HadwigerNelson/Plane/Saturated/Basic.lean` (the planner and the other implementer both read it: a need there is a message), the wave's other file, the planners' record, any landed module beyond new declarations, `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are proving the first leaves of wave 6 of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–5 are on `main`. Wave 6 is about *saturated* colourings — measurable colourings whose classes are carved by unit
circles about their own points — and its first theorem is the pinch: where exactly two colours meet and each has a point of its own class at
distance 1, the two contacts are one point or antipodal, and the interface there is a unit arc or lies between two tangent unit discs. Two
planners have laid the wave's foundation; the second restated every predicate this morning over two sets on an open set, which is the class the
argument reads, and fixed the statements at the commit your branch is cut from. Nothing is proved over them yet. This file is yours.

## Why this job

A result counts as held only when its Lean module passes the gate. Everything else in the wave — the fan at a singular point, the ladder, the
fragment — reads these leaves, and a deriver's argument filed today (the bridge from "the singular set is locally finite" to the fan) applies the
pinch at every point of one neighbourhood, which is why its statement was widened. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

What the planners handed back and the rulings in force (read each item whole in the inventory):

> 486. **FS131-K6 done at its Stage 7: wave 6's first planning pass — dispositions for all 35 rows, the foundation, four rows proved at a wider
> — source: plans/FS131-close-inventory.md

> 495. **FS131-K6b, by message mid-job (`fs131-w6` at `3928644b`, pushed): wave 6's foundation is restated and saved — the statements of
> — source: plans/FS131-close-inventory.md

> 490. **FS131-E8, by message mid-job (its Stage 3 saved, `0310d854` on `main`, pushed): the bridge under REG-J′ is derived — the frozen
> — source: plans/FS131-close-inventory.md

## The statements

No statement changes in this job. Your leaves, as they stand in your tree (read each whole, with its docstring):

> theorem pinch_not_in_in {A B N : Set ℂ} (hN : IsOpen N) (hcover : (N : Set ℂ) ≤ᵐ[volume] (A ∪ B : Set ℂ))
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6p/Proofs/HadwigerNelson/Plane/Saturated/Pinch.lean

> theorem pinch {A B N : Set ℂ} (hA : MeasurableSet A) (hAn : UnitPairsNull A) (hB : MeasurableSet B)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6p/Proofs/HadwigerNelson/Plane/Saturated/Pinch.lean

> theorem TwoColourOn.essBoundary_inter_eq {A B N : Set ℂ} (hA : MeasurableSet A) (hB : MeasurableSet B)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6p/Proofs/HadwigerNelson/Plane/Saturated/Pinch.lean

> theorem c11_discs {A B N : Set ℂ} (hA : MeasurableSet A) (hAn : UnitPairsNull A) (hB : MeasurableSet B)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6p/Proofs/HadwigerNelson/Plane/Saturated/Pinch.lean

> theorem c11_split {A B N : Set ℂ} (hN : IsOpen N) {x y : ℂ} (h : IsSplitAt A B N x y) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6p/Proofs/HadwigerNelson/Plane/Saturated/Pinch.lean

> theorem half_upperDensity {A : Set ℂ} (hA : MeasurableSet A) (hnull : UnitPairsNull A) {x y : ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6p/Proofs/HadwigerNelson/Plane/Saturated/Pinch.lean

> theorem sq9_isTangentAt :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6p/Proofs/HadwigerNelson/Plane/Saturated/Pinch.lean

The plans (the planners' record, `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6p/plans/FS131-w6-kernel-plan.md`: read Stages 3, 5, 7 and 9
whole — the second planner's § 9.4 changes the first's § 5 where the statements changed, and § 9.1 says what each predicate is and why):

> ## Stage 9 — SAVED: the foundation restated over two sets and a family (`debruijn-domain-modeling`, invoked fresh)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6p/plans/FS131-w6-kernel-plan.md

> ### 9.2 The leaves restated, each against its row (`data/fs131/k6/backlog-rows-w6.md`)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6p/plans/FS131-w6-kernel-plan.md

> ### 9.4 The plan per leaf, where it changed (the first pass's § 5 otherwise stands)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6p/plans/FS131-w6-kernel-plan.md

> ## Stage 5 — SAVED: the plan per leaf (`debruijn-obligation-modeling`, invoked fresh)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6p/plans/FS131-w6-kernel-plan.md

## Done means

1. **Your readback first**: check the quotations against their sources; read the planners' record (Stages 1–9), `Basic` whole and your file,
   and your rows' derivation entries at the addresses the record's § 2 gives (`plans/FS111-M-regularity.md` §§ 2.1, 3.1–3.6 for the pinch).
   Build the branch once as given (eight `sorry` leaves over the two files: seven yours, one the other implementer's). Open your record with what you may and may not change. Commit and push.
2. **The leaves**, in the order the plans give — `pinch_not_in_in` first (`pinch` uses it), `pinch`, `TwoColourOn.essBoundary_inter_eq`, `c11_discs`, `c11_split`; `half_upperDensity` and `sq9_isTangentAt` are independent of the rest; saving after each leaf or group (a build, the axioms print for it with a control that fires, a statement check
   against `3928644b`, commit, push). Re-price after your first two leaves and say so: the first planner expects its prices to be high by a
   factor of two to three.
3. When `sq9_isTangentAt` is proved, `half_upperDensity` and `pinch` have their Lean model (`sq9` at `sqEdgePt`): say so in each docstring, in `LEAN.md` § The gate's form (a docstring line is not a statement change; your statement check says which lines it allows).
4. No statement or definition changed; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not merge
   another branch, run the gate, or touch `main`. Leave no background process running, and keep what your record cites under your `data/`
   folder.
5. **Your record**, stages headed "Stage n — SAVED (FS131-I6A)", "Theorems this phase proved", each read against its row; the report in standing
   rule 11's form, ending with what is left and its route. Stopping at a saved stage with part of the leaves proved is a good report.

## What is yours to decide

The route inside each leaf, your helpers and where they live, and the order within the plans' dependencies. The plans are two minds' on paper,
written before any of these proofs existed; change a route that does not go and say so. A statement is not yours to change: one that is false,
or true only with a hypothesis the plan did not see, is a message to me, and a finding — the second planner's mutation audit (its § 9.2) says
which hypotheses it believes each statement needs, and a proof that never reads one of them is worth a line in your report. Three failed attempts
on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.
