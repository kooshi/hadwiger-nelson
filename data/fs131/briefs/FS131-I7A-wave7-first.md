# Brief FS131-I7A — wave 7, route T's count on a combinatorial map: the open leaves of the first planning pass, on `fs131-w7a`

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I7A
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 7's first implementer — prove the open leaves of `Proofs/HadwigerNelson/Plane/RouteT/Count.lean` (nineteen leaves, and the two inhabitants of `CountData` the plan derives) and, if budget remains, `Proofs/HadwigerNelson/Plane/RouteT/Rainbow.lean` (one leaf, `anchor`) from the planner's plan, without changing a statement, saving after each leaf or group
  launch: when a slot frees, on a branch cut from the commit at which the wave's first planner (FS131-K7) handed back; a second planning pass may run beside you on the planner's branch, adding modules
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf whose statement is false or cannot be proved as stated (at once, with the configuration: a statement change goes back through me), a step of the plan's route that fails (with its address), a certificate or tool that disagrees with the kernel, a definition in the wave's foundation you need changed, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I7A.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I7A-implementation.md` (new, on branch `fs131-w7a`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a` (branch `fs131-w7a`, cut from `fs131-w7` at `b5ef0e39`): `Proofs/HadwigerNelson/Plane/RouteT/Count.lean` (nineteen leaves, and the two inhabitants of `CountData` the plan derives) and, if budget remains, `Proofs/HadwigerNelson/Plane/RouteT/Rainbow.lean` (one leaf, `anchor`) — proofs, and new helper declarations under names no other module declares (`LEAN.md` § Searching — Lean, last bullet: two branches never state one lemma under one name; run `./scripts/dupnames.sh` before each push that adds names); a new module of your own beside them if the helpers or a model want one, with `Proofs.lean` and `ARCHITECTURE.md` for it; `scripts/Axioms.lean` (a block of your own, headed "FS131-I7A", above the `=== PURCHASED ===` banner), `plans/FS131-I7A-implementation.md`, `tools/fs131_i7a_*.py`, `data/fs131/i7a/`, `data/fs131/reports/FS131-I7A.md`; **not** the wave's foundation modules or any statement, the planner's record, any landed module beyond new declarations, `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are proving part of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into kernel-checked ones;
waves 1–5 are on `main`. Wave 7 is twenty rows: the seven of *route T's count* — a count over the tiles of a map that bounds how many colours it can
carry — and thirteen about four-colour vertices. Its first planner stated the seven on a *combinatorial map* (a rotation system on darts, with
`V − E + F = 0` a hypothesis; Euler's formula is not imported), proved three of them in part or whole, and left the count's leaves open.
They are yours. A second planner will state the thirteen four-colour rows in new modules; nothing of yours waits on it.

## Why this job

A result counts as held only when its Lean module passes the gate. These rows are what the frontier's open stub on route T's count
(FS-117; `CLAUDE.md` § The aim, the program) stands on, and the planner found them wider than filed: the count holds at every Euler
characteristic at most 0, not only on a torus. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

What the planner handed back and the rulings in force (read each item whole in the inventory):

> 512. **FS131-K7, by message mid-job: route T's rows — three proved on the way, six generalizations, three hypotheses the formal
> — source: plans/FS131-close-inventory.md

> 513. **FS131-K7 done at its Stage 4: wave 7's first planning pass — route T's seven rows stated on a combinatorial map, three proved in
> — source: plans/FS131-close-inventory.md

## The statements

No statement changes in this job. Your leaves, as they stand in your tree (read each whole, with its docstring):

> theorem sigma_bijOn (c : D) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/Proofs/HadwigerNelson/Plane/RouteT/Count.lean

> theorem card_slotSet (hdeg : ∀ v, 2 ≤ M.deg v) (f : F) : (#(M.slotSet f) : ℤ) = M.slots f := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/Proofs/HadwigerNelson/Plane/RouteT/Count.lean

> theorem nbrs_subset_slotFace (hdeg : ∀ v, 3 ≤ M.deg v) (f : F) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/Proofs/HadwigerNelson/Plane/RouteT/Count.lean

> theorem mu_eq_zero_iff (hdeg : ∀ v, 3 ≤ M.deg v) (f : F) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/Proofs/HadwigerNelson/Plane/RouteT/Count.lean

> theorem card_edgeNbrs (x : F) : #(M.edgeNbrs x) = M.len x := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/Proofs/HadwigerNelson/Plane/RouteT/Count.lean

> theorem card_vertNbrs (x : F) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/Proofs/HadwigerNelson/Plane/RouteT/Count.lean

> theorem absent_nonneg (x : F) : 0 ≤ C.absent x := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/Proofs/HadwigerNelson/Plane/RouteT/Count.lean

> theorem deg_le (v : V) : M.deg v ≤ k := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/Proofs/HadwigerNelson/Plane/RouteT/Count.lean

> theorem tile_identity (x : F) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/Proofs/HadwigerNelson/Plane/RouteT/Count.lean

> theorem absentNbrs_le (x : F) : (C.absentNbrs x : ℤ) ≤ 3 * C.absent x := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/Proofs/HadwigerNelson/Plane/RouteT/Count.lean

> theorem two_mul_card_tac_le : 2 * #C.tac ≤ Fintype.card D := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/Proofs/HadwigerNelson/Plane/RouteT/Count.lean

> theorem count_poly : ∑ v, poly k (M.deg v) ≤ 3 * ((k : ℤ) - 1) * M.chi2 := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/Proofs/HadwigerNelson/Plane/RouteT/Count.lean

> theorem five_count [Nonempty D] (C : CountData M 5) (hχ : M.chi2 ≤ 0) : False := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/Proofs/HadwigerNelson/Plane/RouteT/Count.lean

> theorem room (C : CountData M 6) (hχ : M.chi2 = 0) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/Proofs/HadwigerNelson/Plane/RouteT/Count.lean

> theorem slack (C : CountData M 6) (hχ : M.chi2 = 0) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/Proofs/HadwigerNelson/Plane/RouteT/Count.lean

> theorem ends_identity [DecidableEq D] (C : CountData M 6) (hχ : M.chi2 = 0) : ∑ p, C.charge p + 2 * C.unused = 0 := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/Proofs/HadwigerNelson/Plane/RouteT/Count.lean

> theorem joint_first [DecidableEq D] (C : CountData M 6) (hχ : M.chi2 = 0) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/Proofs/HadwigerNelson/Plane/RouteT/Count.lean

> theorem kill [DecidableEq D] (C : CountData M 6) (hχ : M.chi2 = 0) (hK1 : ∀ p, M.deg p = 4 → 2 ≤ C.nonTac p) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/Proofs/HadwigerNelson/Plane/RouteT/Count.lean

> theorem joint (C : CountData M 6) (hχ : M.chi2 = 0) (w : D → V → ℚ) (u : ℚ)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/Proofs/HadwigerNelson/Plane/RouteT/Count.lean

> theorem anchor {x z : Set ℂ} (hx : F.IsTile x) (hz : F.IsTile z) {q : ℂ} (hq : q ∈ F.dom)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/Proofs/HadwigerNelson/Plane/RouteT/Rainbow.lean

The plan (the planner's record, `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/plans/FS131-w7-kernel-plan.md`: read it whole; the
sections quoted give a route per leaf, the lemmas it confirmed, what is hard, and a price):

> ### 3.2 The outside theorem — decided
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/plans/FS131-w7-kernel-plan.md

> ### 3.3 What is on the branch
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/plans/FS131-w7-kernel-plan.md

> ### 3.5 The plan per leaf (Mathlib names confirmed with `#check` at the pin, `data/fs131/k7/logs/check-names.log`)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/plans/FS131-w7-kernel-plan.md

> **Inhabitants owed before the gate** (the implementer's; each exercises its clauses): `CountData 9` on the `3 × 3` square torus
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/plans/FS131-w7-kernel-plan.md

> ### 4.4 The handoff
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/plans/FS131-w7-kernel-plan.md

> - **I7A, `Plane/RouteT/Count`** (19 leaves; about 200–250k): in the order `sigma_bijOn`, `card_slotSet`, `nbrs_subset_slotFace`,
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/plans/FS131-w7-kernel-plan.md

> - **I7B, `Plane/RouteT/Rainbow`'s `anchor`** (one leaf, about 60k; reads wave 3's `localSectors`) — small enough to ride with the
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/plans/FS131-w7-kernel-plan.md

## Done means

1. **Your readback first**: check the quotations against their sources; read the planner's record whole, your files and the modules they
   import, and each row's derivation entry at the address the record gives. Build the branch once as given (20 `sorry` leaves: nineteen in `Count`, one in `Rainbow`). Open your record with
   what you may and may not change. Commit and push.
2. **The leaves**, in this order — the handoff's order for `Count` (its four groups, quoted above), then the two grids as `CountData` inhabitants, then `anchor` if budget remains; saving after each leaf or group (a build, the axioms print for it with a control that fires, a
   statement check against `b5ef0e39`, commit, push). Re-price after your first two leaves and say so: this milestone's implementers have come in
   at a third to two thirds of their planners' line counts.
3. **The inhabitants are part of done**: `CountData 9` on the `3 × 3` square torus and `CountData 15` on the `4 × 4`, as the plan derives
   them by hand (quoted above; no search — if a field fails in the kernel, the hand derivation is wrong at a named place, and that is a message).
   Their fields are closed terms over a finite type: measure the kernel's time on one field before choosing the shape (`LEAN.md` § The kernel's
   cost model; no `native_decide`). Each is a named declaration with its record in `scripts/Axioms.lean`, an `example` applies a proved theorem
   of yours to it, and the count's theorems name it in their docstrings in `LEAN.md` § The gate's form. `five_count` is a refutation: its
   docstring says no `CountData 5` at Euler characteristic at most 0 exists, and names the object meeting every other hypothesis.
4. **What the kernel will not hold, and no docstring may suggest** (ruling 512 (i)): that a doubly periodic valid map gives such a combinatorial
   map. The rows are theorems about `CMap` and `CountData`; write "a combinatorial map with `chi2 = 0`", never "a torus map" of an `ArcMap`.
5. **`anchor` last, if budget remains** (my ruling: the planner proposed it ride with the second pass's first implementer; no such job exists
   until that pass hands back, the file is nobody else's, and its price is about 60k). It reads wave 3's `localSectors`; its model is `sixFrag`'s
   centre, by the plan. If your count at the last saved stage of `Count` is past about 350k, leave it and say so.
6. No statement or definition changed; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not merge
   another branch but as this brief says, run the gate, or touch `main`. Leave no background process running, and keep what your record cites
   under your `data/` folder.
7. **Your record**, stages headed "Stage n — SAVED (FS131-I7A)", "Theorems this phase proved", each read against its row; the report in standing
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

## Amendment 1 (2026-10-06, at launch) — your branch starts one merge later than the brief says

Nothing above is withdrawn; two facts changed.

1. **Your branch was fast-forwarded** from `b5ef0e39` to `6f9807b9` (inventory item 549): the wave's second planner merged wave 8's
   foundation module (`Plane/RingCalculus/Basic`, no `sorry`) into the wave's line, and your unstarted branch was moved onto that merge.
   Your two files and the wave's other three modules are byte-identical across it. Your statement check is against `6f9807b9`; the
   branch as given still has twenty `sorry` leaves, nineteen in `Count` and one in `Rainbow`. The first build compiles that one module.
2. **The second planner has handed back** (inventory item 553): it added three modules for the four-colour rows on the planner's
   branch, after the commit yours starts from, and changed none of your files. One of its leaves reads `anchor` as it stands, so a
   statement of yours that turns out false or short of a hypothesis is, as before, a message to me at once — and say which kind you
   have: a *statement* that needs a hypothesis it lacks, or a *route* that reads more than the statement needs (inventory item 526).
