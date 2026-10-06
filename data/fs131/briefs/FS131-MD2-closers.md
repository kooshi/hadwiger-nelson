# Brief FS131-MD2 — three smaller closers on the example maps — a clean map for the procedure's steps, the contact fact at the stuck vertex, a collar package on the outward bend's gap

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-MD2
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: one of two closer jobs on the example maps — prove the facts below about maps that are already on `main`, apply the landed theorems to them, and correct the docstrings that say no Lean model exists; no statement on `main` changes
  launch: when a slot frees, on a branch cut from `main`; the other closer works on a branch of its own, in other files
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a target that is false of the object (at once, with the point or the arc: that is a finding about a landed model), a hypothesis of a landed theorem that no example map can meet, a step of the written route that fails (with its address), or a question you cannot work around; the report goes to `data/fs131/reports/FS131-MD2.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-MD2-implementation.md` (new, on branch `fs131-wd2`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wd2` (branch `fs131-wd2`, cut from `main` at `1ed1cfd2`): a new module `Proofs/HadwigerNelson/Plane/Models/Closers.lean` (or modules, under names of your choice) for every new declaration, with `Proofs.lean` and `ARCHITECTURE.md` for it; `Proofs/HadwigerNelson/Plane/Models/Applied.lean` at the one `example` that takes `IsClean` as given, and nowhere else in that file; the docstrings — docstrings only — of the sixteen heads you serve, in `Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/FlankUA.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/BendGap.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/CollarMapOut.lean` and `Proofs/HadwigerNelson/Plane/ValidMap/BendAway.lean`; `scripts/Axioms.lean` (a block of your own, headed "FS131-MD2", above the `=== PURCHASED ===` banner), `plans/FS131-MD2-implementation.md`, `tools/fs131_md2_*.py`, `data/fs131/md2/`, `data/fs131/reports/FS131-MD2.md`; **not** any statement on `main`; the landed example-map modules (`Proofs/HadwigerNelson/Plane/Models/Stuck.lean` and its three siblings) beyond new declarations you cannot place in your own module; `Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean` and the three `example`s of `Applied` that take `Terminal` or `IsTerminalMap` as given (the other closer's); the six heads left untouched by design and the three that wait on another job's objects (the landing job's list, quoted below), `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are closing open gate items of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–5 and a set of *example maps* are on `main`. The example maps are explicit valid maps of the plane, built so
that each landed theorem about maps can be applied in Lean to an object meeting all its hypotheses at once (this project's gate asks for
that: `LEAN.md` § The gate, the inhabitant rule). Thirty-three of sixty-two such items closed when the maps landed. Sixteen of the
twenty-nine left wait on three facts about maps that already exist: that one of them is *clean* (eleven heads), that a colour at the stuck
vertex has no contact but one (one head), and a named collar package on the outward bend's example (four heads). They are yours.

## Why this job

A result counts as held only when its Lean module passes the gate, and the gate's inhabitant rule is open at these sixteen heads: each
docstring says which hypothesis no Lean object is yet proved to meet. Truth is not in question — every one of the theorems is
kernel-checked — but a hypothesis set nobody has inhabited in Lean is the place a vacuous theorem hides. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

What the landing job handed back and the rulings in force (read each item whole in the inventory):

> 496. **FS131-MC1 done: the example maps are on `main` through the full gate — `a296e60d..edd6aa8d`, a fast-forward; gated commit
> — source: plans/FS131-close-inventory.md

> 497. **Rulings on MC1's held items, and its slot.** (a) **Ruling 482's "fifteen" is superseded by item 496's count**: nineteen stuck
> — source: plans/FS131-close-inventory.md

## The statements

No statement on `main` changes in this job. The targets and what they serve, from the landing job's record and the library (the same files
are in your tree; read each declaration whole, with its docstring):

> def IsClean : Prop := ∀ x ∈ F.Γ, 2 ≤ (F.coloursAt x).ncard
> — source: Proofs/HadwigerNelson/Plane/ValidMap/Limit.lean

> theorem exists_vertexStep (hF : F.Valid) (hc : F.IsClean) {v : ℂ} (hv : F.Covers v 1)
> — source: Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean

> example (hc : hornModel.IsClean) := ArcMap.exists_vertexStep hornModel_valid hc hornModel_covers
> — source: Proofs/HadwigerNelson/Plane/Models/Applied.lean

> theorem hasSectors_one_of_contacts (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) (hM : ¬ F.MergeAvailable v) {j : Fin k}
> — source: Proofs/HadwigerNelson/Plane/ValidMap/FlankUA.lean

>     (hcont : ∀ w, F.IsContact v j w → (w - v = u ∧ F.InType v j w) ∨ (w - v = -u ∧ F.OutType v j w)) :
> — source: Proofs/HadwigerNelson/Plane/ValidMap/FlankUA.lean

> structure CollarFitOut (F : ArcMap k) (P : ℂ) (θ₁ θ₂ : ℝ) (c c' : Fin k) (ε R' R R'' : ℝ) : Prop where
> — source: Proofs/HadwigerNelson/Plane/ValidMap/CollarMapOut.lean

> theorem CollarFitOut.pushOutProfiles (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') :
> — source: Proofs/HadwigerNelson/Plane/ValidMap/CollarMapOut.lean

> theorem CollarFitOut.map_R1 (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') {Q : ℂ} {a b : ℝ} {d d' : Fin k}
> — source: Proofs/HadwigerNelson/Plane/ValidMap/BendGap.lean

> theorem CollarFitOut.map_R2 (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') {Q : ℂ} {a b : ℝ} {d d' : Fin k}
> — source: Proofs/HadwigerNelson/Plane/ValidMap/BendGap.lean

> structure AwayBend (F M : ArcMap k) (h : ℂ ≃ₜ ℂ) (K : Set ℂ) (P : ℂ) (a b : ℝ) (c : Fin k) (ε : ℝ) : Prop where
> — source: Proofs/HadwigerNelson/Plane/ValidMap/BendAway.lean

> theorem AwayBend.idle (hF : F.Valid) {P : ℂ} {a b : ℝ} {c : Fin k}
> — source: Proofs/HadwigerNelson/Plane/ValidMap/BendAway.lean

> theorem awayModel_hyps : awayModel.Valid ∧ awayModel.IsPlaneMap ∧
> — source: Proofs/HadwigerNelson/Plane/Models/Bends.lean

What is written about the routes — the landing job's record (`plans/FS131-MC1-landing.md` §§ 3.2, 3.4 and its fifth draft) and the models'
plan (`plans/FS131-models-kernel-plan.md` §§ 3.3–3.8); read both sections whole:

>      - one hypothesis not a Lean fact (1): `hasSectors_one_of_contacts` (`FlankUA`: `hcont`, that `7` has no contact but the pole);
> — source: plans/FS131-MC1-landing.md

>      - a clean map (11, `Procedure`): `exists_vertexStep` (`hornModel` meets all but `IsClean`), `exists_mergeStep`,
> — source: plans/FS131-MC1-landing.md

>      - a collar or bend package no declaration states for `awayModel` (4): `CollarFitOut.map_R1`, `CollarFitOut.map_R2` (`BendGap`),
> — source: plans/FS131-MC1-landing.md

>      - untouched as ruled, by design (6): `c_ends`, `run_ends` (six colours), `horn_upper_ne_one` (two chain vertices),
> — source: plans/FS131-MC1-landing.md

>      - FS131-E7's `F₀`, `F₁` (3, `UnitArc`): `a4six`, `straddlers_third`, `nb4p` — no Lean object;
> — source: plans/FS131-MC1-landing.md

> **Not served, and why.** `hasSectors_one_of_contacts`: its `hcont` lists every contact of the colour, and only four contacts of
> — source: plans/FS131-MC1-landing.md

> | `exists_vertexStep` (`Procedure`) | `hornModel` | an `example` **taking `hc : hornModel.IsClean` as given** — not proved |
> — source: plans/FS131-MC1-landing.md

> | `exists_vertexStep` (`Procedure`) — `Valid`, `IsClean`, `Covers v 1`, a move available, degree, horn count | `hornModel` (`hornModel_shaveAvailable`, degree `2`, one horn); `twoHornModel` (`twoHornModel_available`; add its degree `4` and horn count `3` — the gap is a horn set too) | **`IsClean`**: every point of `Γ` carries two colours — new arcs separate `7` from a brick colour; brick edges separate different brick colours (the colour is `(c + 3r) mod 7`: neighbours differ by `1, 2, 3`) — M, from `BrickMap`'s sector lemmas |
> — source: plans/FS131-models-kernel-plan.md

## Done means

1. **Your readback first**: check the quotations against their sources; read the two records' sections named above, the example maps'
   modules (`Proofs/HadwigerNelson/Plane/Models/`), and the heads you serve with their docstrings. Build the branch once as given (no `sorry` anywhere: this is
   `main`). Open your record with what you may and may not change. Commit and push.
2. **A clean map** (eleven heads): `hornModel.IsClean` — every point of `Γ` carries two colours; the models' plan priced it M and names
   the argument (quoted above). Then the `example` in `Applied` loses its binder, and for each of the other ten heads of
   `Procedure` either an application to a model in your module, or one line in your record naming the hypothesis that model still does not
   meet — an honest list is the deliverable, not eleven ticks. My reading of that row, unchecked: `twoHornModel` should be clean by the same argument, if a head wants a
   repeated colour.
3. **The contact fact** (one head): that colour `7` at `stuckModel`'s vertex has no contact but the pole, in the form
   `hasSectors_one_of_contacts`'s `hcont` asks; then the application.
4. **A collar package** (four heads): a named `CollarFitOut` — and an `AwayBend` if `AwayBend.idle` needs one — on `awayModel`'s gap, the
   sub-arc the landed applications already use; then the four applications. If the package's fields ask more than the gap gives, say which
   field, and stop there: that is a finding about the heads' hypotheses.
5. **The close**: each served head's docstring names its model in `LEAN.md` § The gate's form in place of its open-item sentence
   (docstring edits rebuild everything downstream: make them last, in one pass, and show by a statement check that no statement moved).
   **Checks, each saved**: the build with 0 warnings; no `sorry`; the axioms print for your declarations with a control that fires;
   `./scripts/dupnames.sh`; `python3 tools/fs131_qa4_notes.py` (no CONFLICT); `python3 tools/fs131_mc_gateitems.py` — the count of open
   gate items it reads from the docstrings, before and after (29 at the landing).
6. No statement or definition on `main` changed; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. **You do not
   land**: you do not merge another branch, run the full gate, or touch `main` — the next landing job merges your branch (my ruling: a full
   gate for a handful of docstring lines is a landing spent on nothing new, and nothing waits on these). Leave no background process
   running, and keep what your record cites under your `data/` folder.
7. **Your record**, stages headed "Stage n — SAVED (FS131-MD2)", "Theorems this phase proved"; the report in standing rule 11's form, ending
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
