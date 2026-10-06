# Brief FS131-MD1 — the stuck example map is a terminal map — `stuckModel.IsTerminalMap` whole, so three landed theorems name a Lean model of all their hypotheses

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-MD1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: one of two closer jobs on the example maps — prove the facts below about maps that are already on `main`, apply the landed theorems to them, and correct the docstrings that say no Lean model exists; no statement on `main` changes
  launch: when a slot frees, on a branch cut from `main`; the other closer works on a branch of its own, in other files
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a target that is false of the object (at once, with the point or the arc: that is a finding about a landed model), a hypothesis of a landed theorem that no example map can meet, a step of the written route that fails (with its address), or a question you cannot work around; the report goes to `data/fs131/reports/FS131-MD1.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-MD1-implementation.md` (new, on branch `fs131-wd1`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wd1` (branch `fs131-wd1`, cut from `main` at `1ed1cfd2`): a new module `Proofs/HadwigerNelson/Plane/Models/StuckTerminal.lean` (the three target declarations and your helpers), with `Proofs.lean` and `ARCHITECTURE.md` for it; `Proofs/HadwigerNelson/Plane/Models/Applied.lean` at the three `example`s that take `Terminal` or `IsTerminalMap` as given, and nowhere else in that file; the docstrings — docstrings only — of `n3_end_chain`, `cv_l0` and `hornBoundsQR_of_isChainVertex` in `Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean`; `scripts/Axioms.lean` (a block of your own, headed "FS131-MD1", above the `=== PURCHASED ===` banner), `plans/FS131-MD1-implementation.md`, `tools/fs131_md1_*.py`, `data/fs131/md1/`, `data/fs131/reports/FS131-MD1.md`; **not** any statement on `main`; the landed example-map modules (`Proofs/HadwigerNelson/Plane/Models/Stuck.lean` and its three siblings) beyond new declarations you cannot place in your own module; the docstrings of `c_ends`, `run_ends` and `horn_upper_ne_one` (ruling 482: their open-question and refutation lines stay untouched); the heads the other closer serves (`Procedure`, `FlankUA`, `BendGap`, `CollarMapOut`, `BendAway`), `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are closing an open gate item of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–5 and a set of *example maps* are on `main`. The example maps are explicit valid maps of the plane, built so
that each landed theorem about maps can be applied in Lean to an object meeting all its hypotheses at once (this project's gate asks for
that: `LEAN.md` § The gate, the inhabitant rule). One of them, `stuckModel` — a twelve-colour map with a *stuck* vertex — serves nineteen
theorems today. Three more take one hypothesis it has not been proved to meet: that the whole map is *terminal* (no move available at any
point, and every unit arc of one of two kinds). The job that landed the maps wrote the route and left it for a successor. That is you.

## Why this job

A result counts as held only when its Lean module passes the gate, and the gate's inhabitant rule is open at these three heads: their
docstrings say a hand model exists and no Lean one. Truth is not in question — the three theorems are kernel-checked — but a hypothesis set
nobody has inhabited in Lean is the place a vacuous theorem hides, and this one is a few hundred lines from closed. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

What the landing job handed back and the rulings in force (read each item whole in the inventory):

> 482. **FS131-MC1 asks, and is ruled: the example maps land without `stuckModel_terminal`** (source: MC1's message to "main", 2026-10-06; its
> — source: plans/FS131-close-inventory.md

> 496. **FS131-MC1 done: the example maps are on `main` through the full gate — `a296e60d..edd6aa8d`, a fast-forward; gated commit
> — source: plans/FS131-close-inventory.md

> 497. **Rulings on MC1's held items, and its slot.** (a) **Ruling 482's "fifteen" is superseded by item 496's count**: nineteen stuck
> — source: plans/FS131-close-inventory.md

## The statements

No statement on `main` changes in this job. The targets and what they serve, from the landing job's record and the library (the same files
are in your tree; read each declaration whole, with its docstring):

> ### 3.2 The work list for a successor: `stuckModel.IsTerminalMap` whole
> — source: plans/FS131-MC1-landing.md

> **Target** (two declarations, to be stated together; `IsTerminalMap` is `Valid ∧ IsPlaneMap ∧ Terminal ∧ QROnly`,
> — source: plans/FS131-MC1-landing.md

>     theorem stuckModel_terminal : stuckModel.Terminal
> — source: plans/FS131-MC1-landing.md

>     theorem stuckModel_qrOnly : stuckModel.QROnly
> — source: plans/FS131-MC1-landing.md

>     theorem stuckModel_isTerminalMap : stuckModel.IsTerminalMap :=
> — source: plans/FS131-MC1-landing.md

> It serves `cv_l0` and `hornBoundsQR_of_isChainVertex` (which take `hM : F.IsTerminalMap`) and `n3_end_chain` (`hT : F.Terminal`);
> — source: plans/FS131-MC1-landing.md

> def Terminal : Prop := F.TerminalOn univ
> — source: Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean

> def QROnly : Prop :=
> — source: Proofs/HadwigerNelson/Plane/ValidMap/Chain.lean

> def IsTerminalMap : Prop := F.Valid ∧ F.IsPlaneMap ∧ F.Terminal ∧ F.QROnly
> — source: Proofs/HadwigerNelson/Plane/ValidMap/Chain.lean

> theorem stuckModel_isStuck : stuckModel.IsStuck plantPt :=
> — source: Proofs/HadwigerNelson/Plane/Models/Stuck.lean

> theorem stuckModel_hyps : stuckModel.Valid ∧ stuckModel.IsPlaneMap ∧ stuckModel.Covers plantPt 1 ∧ stuckModel.IsStuck plantPt :=
> — source: Proofs/HadwigerNelson/Plane/Models/Stuck.lean

> example (hT : stuckModel.Terminal) := ArcMap.n3_end_chain stuckModel_valid stuckModel_isPlaneMap hT stuckModel_isStuck
> — source: Proofs/HadwigerNelson/Plane/Models/Applied.lean

> example (hM : stuckModel.IsTerminalMap) := ArcMap.cv_l0 hM stuckModel_isStuck stuckModel_ncard.le
> — source: Proofs/HadwigerNelson/Plane/Models/Applied.lean

> example (hM : stuckModel.IsTerminalMap) (β : ℝ) := ArcMap.hornBoundsQR_of_isChainVertex hM stuckModel_isChainVertex β
> — source: Proofs/HadwigerNelson/Plane/Models/Applied.lean

What is written about the routes — the landing job's record (`plans/FS131-MC1-landing.md` §§ 3.2, 3.4 and its fifth draft) and the models'
plan (`plans/FS131-models-kernel-plan.md` §§ 3.3–3.8); read both sections whole:

> **The route for `Terminal`, read against wave 5's library; no Lean of it is written.** `Terminal` is: at every `u`, no MERGE (which
> — source: plans/FS131-MC1-landing.md

> | general: two sectors of one colour are one if `F.region c ∩ ball u r` is preconnected; a horn of colour `c` is then that whole set, so no horn if the set approaches `u` along an open interval of directions (`ne_hornSet_of_interior_coneAt`, `coneAt_mono`); an open convex set with `u` in its closure does (`mem_coneAt_of_ray`, Mathlib's `Convex.add_smul_sub_mem_interior'`); a convex set off a closed disc is preconnected when some point `p` of it has `(p − q)·(z − q) ≥ ρ²` for every `z` of it (the segment from `p` then misses the disc) | new, in `Paint` | 110 |
> — source: plans/FS131-MC1-landing.md

> | off the closure of `stuckW`: `stuckModel` agrees with the base there, `isSite_iff_of_agreesOff` (`Procedure` l. 2870), then `sevenBrick_not_hasRepeatedColour`, `sevenBrick_not_isHorn` (`BrickMap`) through `relabel` (interior points are the same by `rfl`; a colour with a sector is `castLE` of a brick colour) | 60 |
> — source: plans/FS131-MC1-landing.md

> | the closed disc about the vertex, `u ≠ plantPt`: no horn by `hasHornCount_zero_of_two_spheres` (`HornChart` l. 166) — `Γ` near `u` lies on `sphere plantPt (1/10)` and one of `ω(N)`, `ω(S′)`, which cross at `Im ((u − v) conj (u − N)) = (u − v).re ≠ 0`. No repeated colour: the classes of `7` and `8` near `u` are intersections of balls; the class of `9` is `ball u r ∩ ball v (1/10)` off one closed unit disc (`u` is outside the other: the two closed discs meet at `v` alone) — empty, convex, or on `ω(N)` star-shaped about `u − (r/2) i` by the criterion above (`(p − N)·(z − N) > 1 − r²/2 + (r/2)(9/10)`); the brick's colour is `ball u r` off `closedBall v (1/10)`, star-shaped about `v + (1 + 5r)(u − v)` | 170 |
> — source: plans/FS131-MC1-landing.md

> | the two closed squares: every painted class near `u` is a wedge cut by the square and the ball, convex and open; the brick's colour is `ball u r` off the closed square — for `r ≤ 1/20` the union of at most two half-balls `{0 < (z − u).re · a_u}`, `{0 < (z − u).im · b_u}` (`a_u`, `b_u` the coordinates of `u − p` that equal `±1/20`), which share a point at a corner | 250 |
> — source: plans/FS131-MC1-landing.md

> | assembly | | 40 |
> — source: plans/FS131-MC1-landing.md

> 500 to 650 lines against the plan's 300–500. Three families of local classes are not convex and carry the geometry: the class of `9`
> — source: plans/FS131-MC1-landing.md

> **`QROnly` is not routed here** (the plan's § 3.8: "the only unit arcs are the four tangent arcs, sides `7`/`9` and `8`/`9`, all
> — source: plans/FS131-MC1-landing.md

> | `Terminal`'s any-`k` family, `cv_l0`, `IsTerminalMap`, `QROnly` | `stuckModel` | `stuckModel_terminal` (stated on `main`, proved here): the vertex is the only site — off the three painted pieces `BrickMap`'s `sevenBrick_not_isHorn`, `sevenBrick_not_hasRepeatedColour` through locality; on them E7 § 7.4's table with squares. `QROnly`: the only unit arcs are the four tangent arcs, sides `7`/`9` and `8`/`9`, all carried at a pole of four colours. H; the pattern is `sevenBrickMap_isTerminalMap` |
> — source: plans/FS131-models-kernel-plan.md

## Done means

1. **Your readback first**: check the quotations against their sources; read the two records' sections named above, the example maps'
   modules (`Proofs/HadwigerNelson/Plane/Models/`), and the heads you serve with their docstrings. Build the branch once as given (no `sorry` anywhere: this is
   `main`). Open your record with what you may and may not change. Commit and push.
2. **`stuckModel_terminal`**, by the route above or a better one, in your module, staged by the table's parts (the general lemmas; off the
   painted pieces; the disc; the squares; the assembly), saving after each. The route is one mind's, read against the library and never
   compiled: re-price after the first part and say so.
3. **`stuckModel_qrOnly`**: no route is written — one paragraph of the landing job's record and one cell of the models' plan, both quoted
   above, are all there is. Write yours in your record before the Lean. If it comes out larger than the `Terminal` half, save `Terminal`,
   say so by message, and go on only as far as budget allows: `stuckModel_terminal` alone closes `n3_end_chain`.
4. **The close**: `stuckModel_isTerminalMap`; the three `example`s in `Applied` lose their binder; the three heads' docstrings name the
   model in `LEAN.md` § The gate's form in place of the hand-model sentence (docstring edits rebuild everything downstream of
   that module: make them last, in one pass, and show by a statement check that no statement moved).
5. **Checks, each saved**: the build with 0 warnings; no `sorry`; the axioms print for your declarations with a control that fires;
   `./scripts/dupnames.sh`; `python3 tools/fs131_qa4_notes.py` (no CONFLICT); `python3 tools/fs131_mc_gateitems.py` — the count of open
   gate items it reads from the docstrings, before and after (29 at the landing).
6. No statement or definition on `main` changed; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. **You do not
   land**: you do not merge another branch, run the full gate, or touch `main` — the next landing job merges your branch (my ruling: a full
   gate for a handful of docstring lines is a landing spent on nothing new, and nothing waits on these). Leave no background process
   running, and keep what your record cites under your `data/` folder.
7. **Your record**, stages headed "Stage n — SAVED (FS131-MD1)", "Theorems this phase proved"; the report in standing rule 11's form, ending
   with what is left and its route, and the gate items by name: closed, and still open with the reason. Stopping at a saved stage with part
   done is a good report.

## What is yours to decide

The routes, your helpers and their names, the layout of your module, and the order within what depends on what. What is written about the
routes is one mind's each and none of it was compiled; change what does not go and say so. A target that is false of the object is not
yours to restate: it is a message to me, and a finding. Three failed attempts on one route is a dispatch to the companion your identity
names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.

## Amendment 1 (2026-10-06, at launch) — `main` has moved since this brief was written; three things to hold

Nothing above is withdrawn.

1. **Your branch was cut from `main` at `1ed1cfd2`, and `main` has since taken four landings** (wave 10's two passes, wave 6's first
   half, and a new gate step). Do not merge it: your modules and what they import are whole in your tree, the build as given is its
   own, and the landing that takes your branch does the merge. Your statement checks are against `1ed1cfd2`.
2. **Read each statement you prove as the kernel has it** (inventory item 556; `LEAN.md` § Searching — Lean, last bullet): a section
   `variable` enters a theorem only if its statement mentions it, so a comparison of text can pass a statement that lacks a
   hypothesis its file shows. `#check` each head with `lake env lean` under the slot, the output saved under your `data/` folder.
3. **After your last green build, the guarded lint** — `lake lint --no-build -- --no-build --trace` under the slot with `--mem 8`
   (`LEAN.md` § The gate), its output saved: a landing's gate went red on an instance argument a proof did not read, which the
   build's own linters do not report (inventory item 573). A line it reports in what you wrote is yours to repair if no statement
   changes, and a message to me if one does.
