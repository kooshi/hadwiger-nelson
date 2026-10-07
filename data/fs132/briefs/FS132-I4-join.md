# Brief FS132-I4 — the join: the ported outside lemmas under the exclusion's skeleton, then the leaves that stand on them, on `fs132-wi4`

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: FS132-I4
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the implementer who joins two finished pieces of work and builds on the join — merge a colleague's port of three outside lemmas under a planner's skeleton, delete the placeholders that stood in for them, and then prove the leaves that rest on those lemmas (the palettes' steps and the ring form's two leaves) and the leaves on null sets through the chart and the final contradiction
  launch: now, in a worktree of your own cut from the planner's final tip; one other implementer is proving the step lemma's module and the shift's on a branch of its own, and a deriver works on `main` — neither writes a file you write
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage **when the join builds** (one line: whether any leaf's statement or call site had to change, and what the merge touched); **at once** for a leaf that is false as stated, vacuous, or provable only with a hypothesis it lacks (say which: the *statement* needs it, or your *route* does), and for a ported statement whose form does not serve the leaf that cites it; and for a question you cannot work around; the report goes to `data/fs132/reports/FS132-I4.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS132-I4-implementation.md` (new, on branch `fs132-wi4`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi4` (branch `fs132-wi4`, cut from branch `fs132-wk1` at `1c5e2609`; its `.lake/build` is its own copy, made today): the merge of branch `fs132-wi2` (the port, tip `4060fe1d`) into your branch; under `Proofs/HadwigerNelson/Plane/SixRing/`: `Placeholders.lean` (deleted at the join), `State.lean`, `Excl.lean`, `TwoPairs.lean` (imports only), `ChartMeasure.lean`, `Kill.lean` (proofs; statements only as the planner's three permissions allow), and the import lines of any module that imported the placeholders; new helper modules beside them if you need them; `Proofs.lean` and `ARCHITECTURE.md` (the merge's two insertions kept, the placeholders' row and line removed, whole new lines for helpers); `scripts/Axioms.lean` (the port's block as merged; a block of your own, headed "FS132-I4"); `plans/FS132-I4-implementation.md`, `data/fs132/i4/`, `data/fs132/reports/FS132-I4.md`; **not** `Proofs/HadwigerNelson/Plane/SixRing/StepLemma.lean` or `Shift.lean` (another implementer's, on branch `fs132-wi3`: you import their statements and do not wait for their proofs), `Chart.lean`, `Tips.lean`, `Winding.lean`, `CyclicCentre.lean` (unassigned lots), anything under `Proofs/HadwigerNelson/Outside/` (generated: a ported statement that does not serve is a message), any landed statement, the planner's record, `CLAUDE.md`, `LEAN.md`, `LEDGER.md`, `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. This project works on the Hadwiger–Nelson problem — how many colours the plane needs so that no two points at distance
1 share one. An outside proof moved the answer to six or seven four days ago; since then this project has derived by hand a
theorem of its own on that ground — in a measurable six-colouring, a point where four colour classes meet in a cycle cannot
have the unit circle about it show the two remaining colours almost everywhere — and Kooshi decided this morning that it is
formalized first. Two colleagues have each finished a half of what that needs. A planner stated the hand proof as forty-nine
leaves across twelve modules, with the theorem already proved from them; it rests on three lemmas of the outside Lean
development, which it wrote as placeholders. An implementer ported those three lemmas with everything under them — one hundred
and sixty-three declarations, kernel-checked here on the standard three axioms, no new axiom. Nobody has yet put the two
together. That is your first step, and the leaves that could not be proved until it was done are the rest of your job.

## Why this job

Kooshi's word of this morning — its last sentence is why the lemmas were ported and not declared — and what he has said of
formalizing:

> > I agree with all 3. let's keep the lean backlog paused. We move to the standard workflow, attacking 6/7. During the lean phase of the workflow, if any dependencies need to be formalized, have those done as well.
> — source: data/external/EXT-OAI1-request.md

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

The join is where two honest pieces of work can still disagree: the planner wrote its placeholders from the release's
statements and says no leaf changes when they are replaced; the porter says its theorems keep the release's names and
binders, so that "the planner's placeholders are a deletion". Both are probably right, and neither has seen the other's
files compile together. If a leaf's statement or a call site must change to meet the ported form, that is not a failure of
anyone's — it is the first thing I want to hear, with the leaf's name. After the join, the leaves on the palettes are where
the hand argument first touches the colouring (its steps M1 to M3), and the two on the chart's null sets and the final
contradiction are the ones the planner ranks hardest. A leaf that will not go through as stated is a result: this theorem
has one derivation, and the kernel is its second check.

## The statements

**The port**, on branch `fs132-wi2` (tip `4060fe1d`; its worktree, to read, is `/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi2/`): eight generated modules under
`/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi2/Proofs/HadwigerNelson/Outside/` beside the palette module, its record `/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi2/plans/FS132-I2-implementation.md` (read its
§§ 2.1, 3.4, 3.5 and its drafts for the landing), its block in the axioms script. Its four targets are
`palette_transfer_pair`, `palette_sixty_disjoint`, `two_state_impossible` and `mem_spatialSupport_ae`, in the namespace
`HadwigerNelson.Outside.OAI158`; it also holds the two lemmas on quasi-measure-preserving maps that the planner's leaves
would cite (`circleSum_quasiMeasurePreserving`, `angleMk_quasiMeasurePreserving`).

**The skeleton**, in your worktree: `/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi4/Proofs/HadwigerNelson/Plane/SixRing/Placeholders.lean` (the three statements as `sorry`, and the fourth with the release's
proof — the file the join deletes), and your four files of leaves. First lines of the leaves — read each whole in its file,
with its docstring, which says in words what step of the argument it is:

> theorem OutsideOrbit.ae_iff_not (h : OutsideOrbit c hc p X Y ψ δ) (hw : WeakColoring k c) (n : ℤ) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi4/Proofs/HadwigerNelson/Plane/SixRing/State.lean

> theorem OutsideOrbit.ae_flip (h : OutsideOrbit c hc p X Y ψ δ) (hw : WeakColoring k c) (n : ℤ) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi4/Proofs/HadwigerNelson/Plane/SixRing/State.lean

> theorem OutsideOrbit.change_at (h : OutsideOrbit c hc p X Y ψ δ) (hw : WeakColoring k c) (m : ℤ) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi4/Proofs/HadwigerNelson/Plane/SixRing/State.lean

> theorem OutsideOrbit.chart_avoids (h : OutsideOrbit c hc p X Y ψ δ) (hw : WeakColoring k c) (n : ℤ) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi4/Proofs/HadwigerNelson/Plane/SixRing/State.lean

> theorem exists_tip (h : OutsideOrbit c hc p X Y ψ δ) (hw : WeakColoring k c) (n : ℤ) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi4/Proofs/HadwigerNelson/Plane/SixRing/State.lean

> theorem OutsideOrbit.hubColours (h : OutsideOrbit c hc p X Y ψ δ) (hw : WeakColoring k c) (n : ℤ) {b : Fin k}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi4/Proofs/HadwigerNelson/Plane/SixRing/State.lean

> theorem OutsideOrbit.hubColours_flip (h : OutsideOrbit c hc p X Y ψ δ) (hw : WeakColoring k c) (n : ℤ)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi4/Proofs/HadwigerNelson/Plane/SixRing/State.lean

> theorem exists_change_of_ae_outside {k : ℕ} {c : ℂ → Fin k} (hc : Measurable c) (hw : WeakColoring k c) (p : ℂ)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi4/Proofs/HadwigerNelson/Plane/SixRing/Excl.lean

> theorem ae_real_of_ae_angles {P : Angles → Prop} (h : ∀ᵐ t ∂angularMeasure, P t) : ∀ᵐ θ : ℝ, P (θ : Angles) := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi4/Proofs/HadwigerNelson/Plane/SixRing/Excl.lean

> theorem chart_quasiMeasurePreserving (p : ℂ) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi4/Proofs/HadwigerNelson/Plane/SixRing/ChartMeasure.lean

> theorem shear_quasiMeasurePreserving {f : ℝ × ℝ → ℝ} (hf : Measurable f) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi4/Proofs/HadwigerNelson/Plane/SixRing/ChartMeasure.lean

> theorem ae_ne_of_not_isTip {k : ℕ} {c : ℂ → Fin k} (hc : Measurable c) {p : ℂ} {ψ : ℝ} {n : ℤ} {i : Fin k}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi4/Proofs/HadwigerNelson/Plane/SixRing/ChartMeasure.lean

> theorem unitPair_chart_ae {k : ℕ} {c : ℂ → Fin k} (hc : Measurable c) (hw : WeakColoring k c) (p : ℂ) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi4/Proofs/HadwigerNelson/Plane/SixRing/ChartMeasure.lean

> theorem no_double_change (hc : Measurable c) (hw : WeakColoring k c) (p : ℂ) {b X Y : Fin k} {S : Set ℝ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi4/Proofs/HadwigerNelson/Plane/SixRing/Kill.lean

> theorem step_kill (hc : Measurable c) (hw : WeakColoring k c) (p : ℂ) {b X Y : Fin k} {S : Set ℝ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi4/Proofs/HadwigerNelson/Plane/SixRing/Kill.lean

**The planner's record**, `/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi4/plans/FS132-kernel-plan.md` — read its Stages 5 to 7 whole (§ 5.1 the modules and the lots; § 5.2 the assembly read
back; § 5.3 each leaf's readback, model, route with the Mathlib names it `#check`ed, size, and whether it waits on the port;
§ 7.1 where a successor takes over). What it says of the lots, its permissions, the hard leaves, and the join:

> A, B, C need nothing ported and share no file: **three implementers can start now**. D needs `Chart` and `Shift`'s
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi4/plans/FS132-kernel-plan.md Stage 5

> **The planner's standing permissions to an implementer** (so that a round trip is not needed for these): (1) a hypothesis a
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi4/plans/FS132-kernel-plan.md Stage 5

> **Hard, in order**: `unitPair_chart_ae`, `step_kill`, `volume_pattern_pos`, `exists_density_pair`, `exists_shift_lipschitz`.
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi4/plans/FS132-kernel-plan.md Stage 5

> Nothing of this job is half done. In order of value: (1) when the port lands, delete `Placeholders.lean`, point its three
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi4/plans/FS132-kernel-plan.md Stage 7

**The hand argument**: `/home/kooshi/source/lean-dir/plans/FS132-E3-derivation.md`, Stage 3, steps M1 to M3 (the state on the
ring, the chart, the mixed set), M8's relation and M9 (the final contradiction); and the theorem's entry,
`/home/kooshi/source/lean-dir/plans/FS132-derivation.md` § 1 (read these at those paths: your worktree's copies may predate
them).

## Done means

1. **Your readback first**: the quotations against their sources; the planner's Stages 5 to 7; the port's record sections
   named above; your files whole. Build your branch once as given, under the slot. Open your record. Commit and push.
2. **The join.** Merge branch `fs132-wi2` into yours (a merge commit; the two branches add lines to `Proofs.lean` and
   `ARCHITECTURE.md` side by side — keep both). Delete the placeholders' file, its row and its import line; point its
   importers at the ported modules; build under the slot. **In your record: for each of the four statements, the
   placeholder's form beside the ported theorem's, and every leaf or call site that had to change, or "none".** Run
   `tools/check_architecture.py` and `./scripts/dupnames.sh`. Commit, push, and **message me**.
3. **The leaves on the ported lemmas**: the palettes' module (the state, its flip under the 60° rotation, the change, the
   chart's avoidance, the tip), the ring form's two leaves, and whatever of the two-pair ring's module the join exposes.
   **Before you prove a helper, search this library and the ported modules for its statement's shape, not for a name** — the
   port brought one hundred and sixty-three declarations, and the lemma you need about almost-every direction or about the
   angle chart may be among them.
4. **The leaves on null sets through the chart, and the final contradiction**: the chart is quasi-measure-preserving (the
   planner offers two routes — the release's lemma after a linear change, now ported, or polar coordinates), the shear, the
   unit-pair chart statement the planner ranks hardest, the relation with no double change, and the kill. These import the
   statements of the step lemma and the shift's bounds from the other implementer's two files; you do not need their proofs.
5. **Statements**: unchanged, except by the planner's three permissions, each use reported with the leaf's name and the
   change; anything else is a message to me. No `axiom`, no `native_decide`, no new hypothesis on an existing leaf.
6. **After each file is green**: build under the slot, commit by explicit path, push. After your last green build: your
   block in the axioms script and the axioms printed for every theorem you proved, with a control that fires (the standard
   three and nothing else — the ported lemmas rest on neither declared outside theorem, so nothing above them should);
   `tools/check_architecture.py` exit 0; `./scripts/dupnames.sh`; the guarded lint — `lake lint --no-build -- --no-build --trace`
   under the slot with `--mem 8` (`LEAN.md` § The gate), its output saved. You do not run the full gate or touch `main`.
7. **Your record**, in stages headed "Stage n — SAVED (FS132-I4)", with "Theorems this phase proved", the price as measured;
   the report in standing rule 11's form. **Stopping at a saved stage with the join green and the palettes' module proved is
   a good report** — say exactly which leaves are left, and what each still needs.

## What is yours to decide

How the merge is resolved; the route for every leaf; the helpers and where they live; the order after the join. The planner's
routes are one mind's: change what does not go, and say so. The ported modules are generated — you read them and cite them,
and a statement there that needs another form is a message to me, not an edit. Three failed attempts on one route is a
dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.

## Amendment 1 (2026-10-07, 13:44 UTC, by Keryx) — the other implementer's branch is finished: merge its tip, and two rows

The implementer of the step lemma's module and the shift's (FS132-I3) has handed back: both modules are proved, with no
`sorry`, on the standard three axioms, at the tip of branch `fs132-wi3` (`e9dd2f46`); its record, to read, is
`/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi3/plans/FS132-I3-implementation.md`. You merged that branch at an
earlier commit, when only the first module was done. **Added to your job, and to your touches**: (1) merge the tip of
`fs132-wi3` into your branch at a point of your choosing (its two modules, its block in the axioms script, its record and data
come with it; you write neither of its two Lean files, so the merge should be automatic — say in your record what it
touched); (2) after that merge, the two rows of `ARCHITECTURE.md` for those modules still say "SKELETON": replace their
words by that record's draft 1 (its section "Drafts for the front page"), which its author could not apply under its own
brief; (3) for your information — that branch's `chart_eq_polar_shift`, in the shift's module, states what the leaf
`chart_eq_polar` of the chart's module states, under a name of its own because the shift's module does not import the
chart's: they do not collide, and which of the two stays is for whoever proves the chart's module, not for you. The rule on
agents is unchanged: you start none (standing rule 1: delegation is one level deep, because the coordinator can only review
work it knows exists).

*A note on the gate, by Keryx: re-run on this file after the amendment, the brief gate reports one quotation as no longer
verbatim — the first line of a leaf in your own file of the ring form's two leaves, quoted as it stood at launch and since
proved by you. The quotation was checked at launch (gate exit 0, 21 quotations); the amendment adds none.*

## Amendment 2 (2026-10-07, 13:49 UTC, by Keryx) — the chart's module and the tips' are yours, with a stopping rule

You asked whether to take the two unassigned modules or hand back. **Take them**, after your gate items and a saved stage.
**Added to your touches**: `Proofs/HadwigerNelson/Plane/SixRing/Chart.lean` and `Proofs/HadwigerNelson/Plane/SixRing/Tips.lean`
(proofs; statements only as the planner's three permissions allow, each use reported). The planner's record has each leaf's
readback, model and route in its § 5.3, under the two modules' names; the hand argument's steps for the tips are M4, M5 and M6
of `/home/kooshi/source/lean-dir/plans/FS132-E3-derivation.md`, Stage 3. One thing to know: the shift's module, which you
merged, holds a helper `chart_eq_polar_shift` that states what the chart's leaf `chart_eq_polar` states — the names differ, so
nothing collides; prove the leaf as you judge best, do not change a statement of the shift's module, and say in your record
whether one of the two can go.

**Why you and not a fresh implementer**: you hold the chart's algebra and the files in context, and a successor would spend
its first hundred thousand tokens rebuilding that. **The cost I am weighing against it**: errors rise as a context fills, and
I cannot see your count from here. So, a stopping rule, and it is not a failure to use it: **stop at a saved stage when your
own count reaches about 420k, or at three failed attempts on one leaf, whichever comes first**, and hand back with the leaves
that are left named — a successor takes them from your record. Order: yours; if one module is clearly shorter, finishing it
whole is worth more than half of each.

**When the last leaf is in**: print the axioms of `no_outside_orbit_points`, `no_outside_orbit`, `not_ae_outside` and
`no_alternating_pairs` — with a control that fires — and **message me with those four lines before anything else**: the first
of them on the standard three is the first night's theorem checked by the kernel on your branch, and I report it at once.
The rule on agents is unchanged: you start none (standing rule 1: delegation is one level deep, because the coordinator can
only review work it knows exists).

