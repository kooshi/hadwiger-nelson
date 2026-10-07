# Brief FS124-I1 — the radius clause in the kernel: forty-nine leaves of a planner's skeleton, on `fs124-wk1`

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: FS124-I1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the implementer of the first module of the milestone opened today — replace every `sorry` in three modules of a planner's skeleton with a proof, changing no statement; then make the module ready for a landing: its axioms printed, its records drafted, its checks run
  launch: now, in the planner's own worktree — the planner has handed back and nobody else writes there; a landing of another milestone is in flight on `main`, and a deriver works under `plans/` and `data/` on `main`; you touch neither
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage **at once** for a leaf that is false as stated, vacuous, or provable only with a hypothesis it lacks (say which: the *statement* needs it, or your *route* does); **with one line when the two theorems of the join print their axioms** (the standard three and the one declared outside theorem each names, and nothing else); and for a question you cannot work around; the report goes to `data/fs124/reports/FS124-I1.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS124-I1-implementation.md` (new, on branch `fs124-wk1`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk1` (branch `fs124-wk1`, at `28a82429`; its `.lake/build` is its own, built by the planner today): `Proofs/HadwigerNelson/Plane/WeakColouringOn.lean`, `Proofs/HadwigerNelson/Plane/Radius.lean`, `Proofs/HadwigerNelson/Plane/RadiusOutside.lean` (proofs only; helpers under names no other module declares); new helper modules beside them only if you need them, with whole new lines in `Proofs.lean` and `ARCHITECTURE.md`; `scripts/Axioms.lean` (a block of your own, headed "FS124-I1": the clean records, and the records that rest on a declared outside theorem under the IMPORTED banner, as the planner's § 3.5 lists them); `plans/FS124-I1-implementation.md`, `data/fs124/i1/`, `data/fs124/reports/FS124-I1.md`; **not** any statement or definition of the three modules (a statement that will not go through comes back through me), any other module, `scripts/Assumptions.lean` and `scripts/assumptions-ledger.txt` (the landing's: you draft their lines), the planner's record, `CLAUDE.md`, `LEAN.md`, `LEDGER.md`, `main`
  budget: about 300k by the harness's count, as guidance; you cannot read that count, so use this: **save a stage after each module, and if three attempts on one leaf fail, or you are past the second module with less than half of the third's leaves left to do, stop at a saved stage and hand back** — the planner priced the whole job at well under an hour

Hello. The Hadwiger–Nelson problem — how many colours the plane needs so that no two points at distance 1 share one — stands
at six or seven, and by an outside theorem this library declares, the plane's number is that of measurable colourings proper
at almost every unit pair. This afternoon a deriver of this project showed by hand how either answer would be reached: six,
if every disc has such a six-colouring — with no regularity asked of it at all; seven, if one disc has none. A planner then
stated that as a Lean module, working blind from the statements, found the same proof from the other side, and found the
statements hold more widely than claimed. It left a skeleton that builds, with eight leaves proved and forty-nine to go.
They are yours.

## Why this job

Every later result of this milestone — an exclusion on one disc, a six-coloured fragment of any regularity — will be
consumed through this module, and its last theorem is the form the problem now has: `7 ≤ χ(ℝ²)` if and only if some disc
about the origin has no weak six-colouring. A leaf proved by changing what it says would be worse here than a leaf left
open, because consumers will cite these statements by name. Kooshi's word of this morning, and what he has said of
formalizing:

> > I agree with all 3. let's keep the lean backlog paused. We move to the standard workflow, attacking 6/7. During the lean phase of the workflow, if any dependencies need to be formalized, have those done as well.
> — source: data/external/EXT-OAI1-request.md

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

**The claims**, in the kernel lane's claim list `data/fs124/claims-K1.md` (read it whole): the first lines of three of the five —

> **C124-RADIUS-GRAPH** — statement: Let k ≥ 1, U an open set of the plane, c a weak k-colouring of U, and V a finite subset of U. Then the rigid motions g with g(V) ⊂ U form a non-empty open set, and for almost every one of them the points g(v), g(v′) have different labels for every two points v, v′ of V at distance 1; so the unit-distance graph on V has a proper k-colouring.
> — source: data/fs124/claims-K1.md

> **C124-RADIUS-UP** — statement: For every integer k ≥ 1: if for every R > 0 the open disc of radius R about the origin has a weak measurable k-colouring, then every finite unit-distance graph in the plane has a proper k-colouring, and χ(ℝ²) ≤ k.
> — source: data/fs124/claims-K1.md

> **C124-RADIUS-DOWN** — statement: For every integer k ≥ 1: if χ(ℝ²) ≤ k, every open set of the plane has a weak measurable k-colouring.
> — source: data/fs124/claims-K1.md

**The skeleton**, in your worktree under `/home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk1/Proofs/HadwigerNelson/Plane/`: the shared definition's module, the radius clause's, and the module of the
statements that use a declared outside theorem. The definition and the theorems the module is for (first lines; read each
whole in its file, with its docstring — the planner states the wide forms as the cores and the claims' words as corollaries
under them):

> def AeProperOn (U : Set ℂ) (c : ℂ → α) : Prop := (volume.prod arcLength) (monoPairSet U c) = 0
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk1/Proofs/HadwigerNelson/Plane/WeakColouringOn.lean

> theorem radius_graph {U : Set ℂ} {c : ℂ → Fin k} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {V : Set ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk1/Proofs/HadwigerNelson/Plane/Radius.lean

> theorem radius_countable {U : Set ℂ} {c : ℂ → Fin k} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {V : Set ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk1/Proofs/HadwigerNelson/Plane/Radius.lean

> theorem radius_up (h : ∀ R > (0 : ℝ), ∃ c : ℂ → Fin k, IsWeakColouringOn (ball (0 : ℂ) R) c) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk1/Proofs/HadwigerNelson/Plane/Radius.lean

> theorem radius_down (h : (unitDistance ℂ).chromaticNumber ≤ k) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk1/Proofs/HadwigerNelson/Plane/RadiusOutside.lean

> theorem radius_five : ∃ R > (0 : ℝ), ∀ p : ℂ, ¬ ∃ c : ℂ → Fin 5, IsWeakColouringOn (ball p R) c := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk1/Proofs/HadwigerNelson/Plane/RadiusOutside.lean

> theorem colorable_iff_forall_ball :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk1/Proofs/HadwigerNelson/Plane/RadiusOutside.lean

> theorem seven_le_chromaticNumber_plane_iff_exists_ball :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk1/Proofs/HadwigerNelson/Plane/RadiusOutside.lean

**The planner's record**, `/home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk1/plans/FS124-kernel-plan.md` — read it whole: Stage 2 (the definition, each statement typed and read back, what the
typing found, its modeling pass), Stage 3 (§ 3.1 the routes; § 3.2 **every leaf with its route, its Mathlib names `#check`ed
at this pin, and its size**; § 3.5 what the landing needs), Stage 4 (its route beside the deriver's: one proof), Stage 5
(the price from eight leaves, and where you start). What it says the job costs, and its order:

> **What the module costs**: the 49 leaves left are about 185 lines, none longer than 15, each with its route and its Mathlib
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk1/plans/FS124-kernel-plan.md Stage 5

> 2. Order: `WeakColouringOn` top to bottom (27 left), `Radius` (14 left), `RadiusOutside` (8 left). Each file's order is a
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk1/plans/FS124-kernel-plan.md Stage 5

**The hand argument**, should a leaf's route fail and you want the other side's wording:
`/home/kooshi/source/lean-dir/plans/FS124-E1-derivation.md`, Stage 3 (five entries).

## Done means

1. **Your readback first**: the quotations against their sources; the planner's record; the three modules whole. Build the
   branch once as given, under the slot (it should end with 49 `sorry` warnings and no other). Open your record. Commit
   and push.
2. **The three modules, in the planner's order**, each leaf by its route in § 3.2 unless it fails — then yours, said in your
   record. **Before you prove a helper, search this library and Mathlib for its statement's shape, not for a name.** After
   each module: build under the slot, commit by explicit path, push, a saved stage.
3. **Statements**: unchanged. An unused hypothesis is reported, not dropped — the planner gave this module no written
   permissions, and its statements are fixed; anything that must change is a message to me.
4. **When the last leaf is in**: the axioms of every theorem of the three modules printed, with a control that fires —
   the clean ones on the standard three; the five that use an import each on exactly the one the planner's § 3.5 names;
   **message me with the lines of the two join theorems**. Your block in `scripts/Axioms.lean`; `tools/check_architecture.py`
   exit 0; `./scripts/dupnames.sh`; the guarded lint — `lake lint --no-build -- --no-build --trace` under the slot with
   `--mem 8` (`LEAN.md` § The gate), its output saved. You do not run the full gate, merge another branch, or touch `main`:
   a landing job takes the branch when the landing now in flight is back.
5. **Read aloud**, in your record: `radius_up`, `radius_down` and the two join theorems against the claims' words — and for
   the last, which half needs the import and which does not, as its docstring says.
6. **Your record**, in stages headed "Stage n — SAVED (FS124-I1)", with "Theorems this phase proved", the price as measured
   (leaves, lines, builds), and drafts for the landing (the lines for `scripts/Assumptions.lean` if the definition's
   conditions need declaring; the counts the audit should expect). The report in standing rule 11's form. **Stopping at a
   saved stage with the first two modules proved is a good report** — say exactly which leaves are left.

## What is yours to decide

The route for a leaf whose planned route fails; the helpers and where they live; how you iterate. The planner's routes were
each checked against the pin and eight of them through the build; where one does not go, change it and say so. Three failed
attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.
