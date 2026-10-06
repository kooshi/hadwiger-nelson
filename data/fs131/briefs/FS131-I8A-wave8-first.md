# Brief FS131-I8A — wave 8, the empty class — no Γ-free four-colour vertex in a non-Siamese six-map: the open leaves of the first planning pass, on `fs131-w8a`

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I8A
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 8's first implementer — prove the open leaves of `Proofs/HadwigerNelson/Plane/RingCalculus/Empty.lean` (six leaves on the route to `emptyNS`: `ringPt_sixth_dist_le_one`, `v6_count`, `exists_ne_mem_closure_inter_of_split`, `v6_hug`, `v6_hubs`, `emptyNS`) and, if budget remains, `Proofs/HadwigerNelson/Plane/RingCalculus/Star.lean` (two leaves, `star_recip`, `star_anti`) from the planner's plan, without changing a statement, saving after each leaf or group
  launch: when a slot frees, on a branch cut from the commit at which the wave's first planner (FS131-K8) handed back; a second planning pass may run beside you on the planner's branch, adding modules
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf whose statement is false or cannot be proved as stated (at once, with the configuration: a statement change goes back through me), a step of the plan's route that fails (with its address), a certificate or tool that disagrees with the kernel, a definition in the wave's foundation you need changed, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I8A.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I8A-implementation.md` (new, on branch `fs131-w8a`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a` (branch `fs131-w8a`, cut from `fs131-w8` at `f1c13612`): `Proofs/HadwigerNelson/Plane/RingCalculus/Empty.lean` (six leaves on the route to `emptyNS`: `ringPt_sixth_dist_le_one`, `v6_count`, `exists_ne_mem_closure_inter_of_split`, `v6_hug`, `v6_hubs`, `emptyNS`) and, if budget remains, `Proofs/HadwigerNelson/Plane/RingCalculus/Star.lean` (two leaves, `star_recip`, `star_anti`) — proofs, and new helper declarations under names no other module declares (`LEAN.md` § Searching — Lean, last bullet: two branches never state one lemma under one name; run `./scripts/dupnames.sh` before each push that adds names); a new module of your own beside them if the helpers or a model want one, with `Proofs.lean` and `ARCHITECTURE.md` for it; `scripts/Axioms.lean` (a block of your own, headed "FS131-I8A", above the `=== PURCHASED ===` banner), `plans/FS131-I8A-implementation.md`, `tools/fs131_i8a_*.py`, `data/fs131/i8a/`, `data/fs131/reports/FS131-I8A.md`; **not** the wave's foundation modules or any statement, the planner's record, any landed module beyond new declarations, `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are proving part of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into kernel-checked ones;
waves 1–5 are on `main`. Wave 8 is twenty-two rows of the *ring calculus*: what the unit circle about a vertex of a valid map (its *ring*) carries, in the class
with no Siamese pair (two tiles of one colour nearer than 1). Its first planner wrote the foundation, proved three rows, and stated eight more
with ten leaves. Six of those leaves are one route, to the theorem that no valid non-Siamese six-coloured map covering a disc about a vertex of at
least four colours has a ring carrying no boundary arc (`emptyNS`). That route is yours; two leaves of a second file follow if budget remains.

## Why this job

A result counts as held only when its Lean module passes the gate. `emptyNS` is the kernel form of the frontier's sentence that a
four-colour vertex whose ring carries no boundary arc dies at `1 + ε` (`CLAUDE.md` § Where the problem stands, item 31; `LEDGER.md` row 148;
its entry is FS129-SR3-EMPTY-NS in `plans/FS129-derivation.md`); the statement here reads the non-Siamese class and no simplicity. The next
milestones' case list starts from it. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

What the planner handed back and the rulings in force (read each item whole in the inventory):

> 518. **FS131-K8, by message mid-job: wave 8's foundation written, three rows proved on the way, five generalizations, a shorter
> — source: plans/FS131-close-inventory.md

> 524. **FS131-K8 done at its Stage 5: wave 8's first planning pass — the foundation, three rows proved, eight rows stated with ten
> — source: plans/FS131-close-inventory.md

> 525. **Rulings on K8's held items, and its slot.** (a) **One implementer, FS131-I8A, on `Plane/RingCalculus/Empty`'s six leaves
> — source: plans/FS131-close-inventory.md

## The statements

No statement changes in this job. Your leaves, as they stand in your tree (read each whole, with its docstring):

> theorem ringPt_sixth_dist_le_one {p : ℂ} {ψ₀ : ℝ} {n m : ℤ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/Proofs/HadwigerNelson/Plane/RingCalculus/Empty.lean

> theorem v6_count (tip : Fin 4 → ZMod 6 → Prop) (hcover : ∀ a, ∃ i, tip i a)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/Proofs/HadwigerNelson/Plane/RingCalculus/Empty.lean

> theorem exists_ne_mem_closure_inter_of_split {p : ℂ} (hp : p ∈ F.dom) {A B : Set (Set ℂ)}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/Proofs/HadwigerNelson/Plane/RingCalculus/Empty.lean

> theorem v6_hug {F : ArcMap 6} (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/Proofs/HadwigerNelson/Plane/RingCalculus/Empty.lean

> theorem v6_hubs {F : ArcMap 6} (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/Proofs/HadwigerNelson/Plane/RingCalculus/Empty.lean

> theorem emptyNS {F : ArcMap 6} (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/Proofs/HadwigerNelson/Plane/RingCalculus/Empty.lean

> theorem v6_hubs_vacuous {F : ArcMap 6} (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/Proofs/HadwigerNelson/Plane/RingCalculus/Empty.lean

> theorem v6_hug_vacuous {F : ArcMap 6} (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/Proofs/HadwigerNelson/Plane/RingCalculus/Empty.lean

> theorem star_recip {F : ArcMap 6} (hF : F.Valid) {p : ℂ} (hp : F.Covers p 2) (h4 : (F.coloursAt p).ncard = 4) {ψ : ℝ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/Proofs/HadwigerNelson/Plane/RingCalculus/Star.lean

> theorem star_anti {F : ArcMap 6} (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/Proofs/HadwigerNelson/Plane/RingCalculus/Star.lean

The plan (the planner's record, `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/plans/FS131-w8-kernel-plan.md`: read it whole; the
sections quoted give a route per leaf, the lemmas it confirmed, what is hard, and a price):

> ### 5.1 Prices, from the first leaves
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/plans/FS131-w8-kernel-plan.md

> ### 5.2 `Empty` — the route to `emptyNS`
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/plans/FS131-w8-kernel-plan.md

> - **`v6_hubs`** (the hard leaf; about 600–900 lines). The statement the proof derives from: *on a covered Γ-free ring every germ lies in
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/plans/FS131-w8-kernel-plan.md

> - **`ringPt_sixth_dist_le_one`**: `dist (r α) (r β) = 2 |sin((α − β)/2)|` (look for `dist_ringPt_ringPt_cmp_one`, `Plane/Chord` or
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/plans/FS131-w8-kernel-plan.md

> - **`v6_hug`**: V6's argument verbatim (`plans/FS116-V6-verification.md` ll. 148–161). Children: (a) `T`'s cone at `y` ends at
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/plans/FS131-w8-kernel-plan.md

> - **`v6_count`**: a certified computation. Encode a tile's tip set as one of 13 values (none, one hub, two consecutive hubs), prove the
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/plans/FS131-w8-kernel-plan.md

> - **`exists_ne_mem_closure_inter_of_split`**: `finite_tiles_near` gives `r` with finitely many tiles meeting `B(p, r)`; shrink `r` below
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/plans/FS131-w8-kernel-plan.md

> - **`emptyNS`**: the composition. From `v6_hubs` take `ψ₀`; index the four tiles of `p` by `Fin 4` (the four colours of `p`; a transport
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/plans/FS131-w8-kernel-plan.md

> ### 5.3 `Star` — the two open leaves
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/plans/FS131-w8-kernel-plan.md

> - **`star_recip`** (about 150 lines): `Covers y 1` from `Covers p 2`; `(coloursAt y)ᶜ ⊆ coloursAt p` from `star_absent`; both germs of `ω(y)`
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/plans/FS131-w8-kernel-plan.md

> - **`star_anti`** (about 250 lines): `SimpleOn.coneAt_eq_angleIcc_sep` at `p` for `t⁺`, `t⁻`; `star_flank_interior` puts both colours in
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/plans/FS131-w8-kernel-plan.md

> ### 5.4 The statements, attacked (the pass's validation)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/plans/FS131-w8-kernel-plan.md

> | `emptyNS` | a refutation; its hypotheses hold together at `k = 9` on SQ9's lattice vertex — the Lean term `sq9 : ArcMap 9` with `Valid`, `NonSiamese`, `Covers`, four colours and `GammaFreeRing` is **owed before the wave's gate** (wave 6 owes `sq9` already, item 486) |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/plans/FS131-w8-kernel-plan.md

> | `star_flank`, `star_outer_cone`, `v6_anti`, `ringPt_sixth_dist_le_one`, `exists_ne_mem_closure_inter_of_split` | class-free; any valid map with a vertex is a model (`stuckModel`, `sixFrag`) — a named `example` each is owed before the gate |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/plans/FS131-w8-kernel-plan.md

> ### 5.6 The handoff
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/plans/FS131-w8-kernel-plan.md

> - **Two implementers, by file**: *I8A* on `Plane/RingCalculus/Empty` — `ringPt_sixth_dist_le_one`, `v6_count`,
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/plans/FS131-w8-kernel-plan.md

## Done means

1. **Your readback first**: check the quotations against their sources; read the planner's record whole, your files and the modules they
   import, and each row's derivation entry at the address the record gives. Build the branch once as given (10 `sorry` leaves: eight in `Empty` (six yours; `outerAdj` and `doubleTip` wait for the second planning pass and stay), two in `Star`). Open your record with
   what you may and may not change. Commit and push.
2. **The leaves**, in this order — the handoff's order for `Empty` — `ringPt_sixth_dist_le_one`, `v6_count`, `exists_ne_mem_closure_inter_of_split`, `v6_hug`, `v6_hubs`, then `emptyNS`; then `star_recip`, `star_anti` if budget remains; saving after each leaf or group (a build, the axioms print for it with a control that fires, a
   statement check against `f1c13612`, commit, push). Re-price after your first two leaves and say so: this milestone's implementers have come in
   at a third to two thirds of their planners' line counts.
3. **The model is owed, and is not yours** (ruling 525 (c), amended by inventory item 530): `emptyNS` is a refutation at six colours, and the
   gate's inhabitant rule asks for a Lean object meeting its hypotheses but the one it fails. That object is wave 6's nine-colour grid map,
   which now exists: `sq9Map : ArcMap 9`
   (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6m/Proofs/HadwigerNelson/Plane/Saturated/Sq9Map.lean`, on `origin/fs131-w6m` at
   `2e55a2d6`), with `IsPlaneMap` proved and nothing yet about `Valid`, `NonSiamese`, `Covers`, the colours at a lattice vertex or its ring.
   Those five facts are a job after yours, on a line that holds both waves: do not merge that branch (it carries another wave's open
   leaves) and do not build a nine-colour map of your own. `emptyNS`'s docstring says the model is owed and names the map and the facts.
4. **Declared vacuity stays as the planner left it** (ruling 518): `v6_hubs` and `v6_hug` are public, each with its `VACUITY DECLARED` line and a
   companion (`v6_hubs_vacuous`, `v6_hug_vacuous`) deriving `False` from its exact hypotheses through `emptyNS`. Do not make them private, and
   do not weaken the companions: when `emptyNS` is proved they are kernel facts. The planner's caution on `v6_hubs` is in its plan — the count
   alone does not give one change point per sixth of the ring, and the colour argument is a child (H4, H7) — read it before you start that leaf.
5. **`v6_count` is a certified computation**: measure the kernel's time on the encoded statement before choosing between `decide +kernel` and
   the five-line hand count (the plan gives both; `LEAN.md` § The kernel's cost model; no `native_decide`). The planner's tool
   (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8a/tools/fs131_k8_count.py`) counts 72 configurations: if the kernel disagrees, stop
   and report.
6. No statement or definition changed; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not merge
   another branch but as this brief says, run the gate, or touch `main`. Leave no background process running, and keep what your record cites
   under your `data/` folder.
7. **Your record**, stages headed "Stage n — SAVED (FS131-I8A)", "Theorems this phase proved", each read against its row; the report in standing
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
