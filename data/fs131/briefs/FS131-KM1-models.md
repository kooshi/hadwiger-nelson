# Brief FS131-KM1 — the example maps planned: Lean objects on which the four moves' hypotheses, the stuck vertex's and the two bends' hold at once

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-KM1
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: plan the models the gate's inhabitant rule is owed on `main` — decide the construction (one overlay or two), lay it out as a skeleton of named definitions and theorems with `sorry` at each leaf, read each back against the theorem it is a model of, a plan and a price per leaf, and a handoff an implementer can build from; prove a leaf yourself where it is short
  launch: when a slot frees, beside implementers on wave 5's branches (`fs131-w5c`, `fs131-w5s`, `fs131-w5a`); your branch is cut from `main` and lands on its own
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a hypothesis set that turns out to have no model (a statement finding: at once), a piece of the library that is private where you need it, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-KM1.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building before your first build
  record: `plans/FS131-models-kernel-plan.md` (new, on branch `fs131-wm`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wm` (branch `fs131-wm`, cut from `main` at `68a3db1d`; `main` has moved since only under `plans/` and `data/`, which you read at their paths in the main tree): new modules under `Proofs/HadwigerNelson/Plane/` for the models, downstream of everything they are models of, with `Proofs.lean` and `ARCHITECTURE.md` for them; `scripts/Axioms.lean` (a block of your own, headed "FS131-KM1", above the `=== PURCHASED ===` banner); `plans/FS131-models-kernel-plan.md`, `tools/fs131_km_*.py`, `data/fs131/km/`, `data/fs131/reports/FS131-KM1.md`; **new declarations only** — no statement, definition or docstring of a landed declaration is edited in this job (the docstring lines that will name your models are drafted in your record, with their slots, for the implementer who lands the lane); not `main`, not wave 5's branches
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are planning the Lean objects that show this milestone's central theorems are about something. The milestone, FS-131, turns this project's
hand-derived results into kernel-checked ones; waves 1–4, Woodall's chain and the moves MERGE and OPEN are on `main`. An audit of every theorem's
hypotheses (FS131-QA4) broke none of them, and found one gap in what Lean holds: the library has maps with a horn or a repeated colour at a point, and
maps that cover the unit disc about a point, and no map with both. So the four local moves the whole termination procedure runs on, the stuck vertex's
family, and two bends have no Lean object satisfying their hypotheses together — each has a hand model. You plan the Lean ones.

## Why this job

The gate's rule, in `LEAN.md` § The gate — read its whole bullet, which begins and turns at these lines:

> - **Every theorem whose hypothesis is a structure** (a colouring, an embedding, a certificate, a homomorphism) **ships a named
> — source: LEAN.md § The gate

>   real instance and the gate stays green. **The inhabitant satisfies every hypothesis the theorem does not refute, at once, at a parameter the refutation leaves alive** — for a
> — source: LEAN.md § The gate

A theorem whose hypotheses cannot hold together is true and empty, and the kernel cannot tell; a model is the one check that can. For the four moves
that check is an open gate item on results already landed, and Kooshi has been told it is open. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

The audit's rows you are planning to (read its §§ 3.1–3.5 and 6 whole: the hand models are there, clause by clause), and the rulings that launch you:

> | 4 | Lean models for the four moves (`exists_merge`, `exists_rayMerge`, `exists_shave`, `exists_open`; landed on `main`), and with them `exists_vertexStep`, `cvb_hole_disconnected`, and positive inhabitants of `IsSite` and `HasHornCount 1` — the whole procedure runs on these moves | **the planted picture** (§ 3.2 (b)): `sevenBrickMap` relabelled into more colours, small open sets inside one brick recoloured in fresh colours by `ArcMap.recolour`; four pictures (two wedges; two horns on a ray; one horn; one lone horn with a tangent disc) | the planner (a short plan: the relabelling, the local facts at `v`), then an implementer | 400–800 lines, plus about 100 per picture; one implementer job | no — truth is not in question (kernel-checked; hand models §§ 3.2–3.3); it clears the open gate item on MERGE and OPEN |
> — source: plans/FS131-QA4-audit.md 6.2 The list of what is owed, ranked by what rests on the theorem

> | 5 | A Lean model of `Valid ∧ Covers v 1 ∧ IsStuck v` — FLANK-Q on `main`, `FlankUA`'s 25 theorems, `Terminal`'s any-`k` stuck lemmas, `woodallCone` | **the completed bowtie** (§ 3.5): the bowtie's eleven tiles kept, the rest of a disc of radius above `1` (or of the plane) filled by fresh-coloured cells; the transfer of `IsStuck 0`, horns, flanks and contacts through "the colours below 6 keep their regions and tiles" | the planner (whether one overlay construction serves ranks 4 and 5), then an implementer | 1,500–3,000 lines by the bowtie's own size (about 2,700); one to two implementer jobs | no; the hand argument of § 3.5 stands meanwhile |
> — source: plans/FS131-QA4-audit.md 6.2 The list of what is owed, ranked by what rests on the theorem

> | 6 | `bend_away_whole`, `bend_toward` (`UnitArc`, landed): no model named | `cuspFrag.IsRingArc I θ₁ θ₂ 0 1` on one side of `0` (a model of both bends: the centre carries no colour) and a docstring line each; for `bend_toward` also `l60Frag` through rank 3's theorem | an implementer, with rank 4's pass | 60–120 lines | no |
> — source: plans/FS131-QA4-audit.md 6.2 The list of what is owed, ranked by what rests on the theorem

> 426. **FS131-QA4 done: the impossible-assumption audit, third pass** (harness ≈ 431k by the task notice; record `plans/FS131-QA4-audit.md`, Stages 1–6;
> — source: plans/FS131-close-inventory.md

> 427. **Rulings on QA4's list and the rule.** (a) **Before wave 5 lands, at its final sync** (one remedy pass, in the job that joins the branches, so no
> — source: plans/FS131-close-inventory.md

> 419. **Rulings on LN1's held items; a correction to ruling 417 (b); the slot.** (a) **The three binders are removed** (two theorems become strictly stronger,
> — source: plans/FS131-close-inventory.md

Since the audit, a deriver (FS131-E7) has answered its two open ranks, and its answer changes your construction: it exhibits by hand a model for
each of four more hypothesis sets and a stuck vertex in a terminal map of the plane, and it finds they are **one construction** — the seven-colour
brick map relabelled into more colours, with small pictures planted by `recolour` — plus one new fragment, a four-petal flower (read its §§ 3, 4, 6
and 7 whole; each ends in a handoff for the implementer):

> 440. **FS131-E7 done: a model for each of the four hypothesis sets, no contradiction; a terminal valid plane map with a stuck vertex exists at
> — source: plans/FS131-close-inventory.md

> 441. **Rulings on E7's held items, and its slot.** (a) **`nb4p` is restated with the one conjunct its proof reads**, at wave 5's remedy pass (the
> — source: plans/FS131-close-inventory.md

> ### 3.7 Handoff: what an implementer needs
> — source: plans/FS131-E7-derivation.md

> ### 6.5 Handoff
> — source: plans/FS131-E7-derivation.md

> ### 7.6 Handoff, and the bearing line for the stub
> — source: plans/FS131-E7-derivation.md

## The statements

No landed statement changes in this job. The theorems your objects are models of, each on `main` and on your branch (read each whole, with its
docstring, at the address):

> theorem exists_merge (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {c : Fin k} {n : ℕ} (hn1 : 1 ≤ n)
> — source: Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean

> theorem exists_rayMerge (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ κ₃ κ₄ : ℝ} {c : Fin k}
> — source: Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean

> theorem exists_shave (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ σ : ℝ} {c g h : Fin k}
> — source: Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean

> theorem exists_open (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {c : Fin k}
> — source: Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean

> theorem bend_toward (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
> — source: Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean

> theorem bend_away_whole (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
> — source: Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean

The pieces the audit proposes to build from — a recolouring of an open set inside a valid map, the seven-colour plane map, the stuck fragment, the
cusp fragment:

> noncomputable def recolour (F : ArcMap k) (W : Set ℂ) (B : Set Arc) (hB : ∀ a ∈ B, a.Nondegenerate) (hBf : B.Finite)
> — source: Proofs/HadwigerNelson/Plane/Woodall/Merge.lean

> theorem recolour_valid (hF : F.Valid) (hWW : ∀ x ∈ W, ∀ y ∈ W, dist x y ≠ 1)
> — source: Proofs/HadwigerNelson/Plane/Woodall/Merge.lean

> noncomputable def sevenBrickMap : ArcMap 7 where
> — source: Proofs/HadwigerNelson/Plane/SVMap.lean

> noncomputable def bowtie : ArcMap 6 where
> — source: Proofs/HadwigerNelson/Plane/ValidMap/BaseSteps.lean

> theorem bowtie_isStuck : bowtie.IsStuck 0 ∧ ¬ bowtie.IsStuck I ∧ ¬ bowtie.IsStuck (-I) := by
> — source: Proofs/HadwigerNelson/Plane/ValidMap/BaseSteps.lean

> noncomputable def cuspFrag : ArcMap 2 where
> — source: Proofs/HadwigerNelson/Plane/ValidMap/Sectors.lean

Two of the theorems owed a model are not on `main` yet: the procedure's vertex step `exists_vertexStep` (being proved on `fs131-w5c`, in
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean`) and the holed tile's
`cvb_hole_disconnected` (on `fs131-w5`, in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/Proofs/HadwigerNelson/Plane/ValidMap/MapGraph.lean`).
Read both; plan your objects so that each is a short application once wave 5 has landed, and say in your record what that application will need.

## Done means

1. **Your readback first**: check every quotation above against its source; read the audit's §§ 3.1–3.5, 4 and 6 and its scratch Lean
   (`data/fs131/qa4/QA4Bowtie.lean`, `data/fs131/qa4/QA4Collar.lean`: three kernel-checked failures of the named fragments, which could land as named
   theorems beside your models); read `recolour` and its lemmas, `sevenBrickMap` with its corner facts, `bowtie` and `cuspFrag`; build the branch once
   as given (the build was copied from an idle tree on `main`'s line, so expect it current). Restate in your record what you are planning and what
   you may change. Commit and push.
2. **The construction decided**, written before the skeleton: the audit proposes a *planted picture* (a plane map given spare colours, small open sets
   inside one tile recoloured in fresh colours — rank 4) and a *completed bowtie* (the stuck fragment's eleven tiles kept, the rest of a disc of
   radius above `1`, or of the plane, filled by fresh-coloured cells — rank 5), and asks whether one overlay construction serves both. Decide that,
   with the reason; say what the library already gives (a colour relabelling `Fin 7 → Fin k′` is said to be missing: check) and what the local facts
   at the vertex cost (sectors, horns, flanks, contacts, cones, `IsClear`, transported through "the old colours keep their regions and tiles").
3. **The skeleton**: the model objects and, for each theorem owed one, a named theorem stating that the object satisfies **every** hypothesis of that
   theorem at once, in the form `LEAN.md`'s rule asks (a conjunction, or the theorem applied to the object, whichever reads back better), with `sorry`
   at each leaf, building through the worktree's `./scripts/build.sh` with only `sorry` warnings; `Proofs.lean`, `ARCHITECTURE.md`
   (`tools/check_architecture.py` exit 0) and `scripts/Axioms.lean` updated; no new `axiom`, no `native_decide`. The models owed, by the audit's list:
   the four moves (two wedges; two horns on a ray; one horn; one lone horn with a tangent disc, so that OPEN's cone clause is exercised); a positive
   inhabitant of `HasHornCount v 1` (and, for after wave 5, of `IsSite`, which is defined on `fs131-w5c` in
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Limit.lean`); a valid map covering `B̄(v, 1)` with `IsStuck v`; a ring arc whose inner colour is absent at its
   centre for `bend_away_whole`, and `bend_toward`'s model; the objects the two wave-5 theorems will apply to; and **E7's four**: the flower `F₀`
   for `a4six`, its recolouring `F₁` for `straddlers_third` and for `nb4p`'s background, `P₄` for `flank_ne_of_doublyShadowed`, and `P₅` — which is
   `Valid ∧ Covers v 1 ∧ IsStuck v` at a fraction of the completed bowtie's size, and a terminal map of the plane besides — in place of the completed
   bowtie unless you find a reason to keep both (ruling 441 (c)). Say which clause of each hypothesis set your object exercises non-trivially and
   which it meets only degenerately. E7's verdicts are one mind's, at hand grade, with numerical controls and nothing kernel-checked: your skeleton
   is their first independent reading, and a clause that fails on one of its objects is a message to me.
4. **Your record**, `plans/FS131-models-kernel-plan.md`: a plan per leaf (route, the Mathlib and library lemmas confirmed with `#check`, what is hard,
   a price), the obligation-modeling pass (`debruijn-obligation-modeling`, invoked fresh), the docstring line each model earns on the theorem it serves
   (text and slot, for the implementer), and a handoff — with how two implementers could split the work by file, and which model to build first if only
   one is wanted soon (the audit's judgment: one fresh-coloured horn in a brick). A leaf you can prove in about an hour, prove, and say so.
5. The report, in standing rule 11's form. You do not merge another branch into this one, run the gate, or touch `main`. Leave no background process
   running, and keep what your record cites under `data/fs131/km/`. Stopping at a saved stage with what is left named is a good report.

## What is yours to decide

The construction, the modules and their names, the form of each model theorem, the number of colours, and the order. The audit's two constructions are
one mind's proposal, priced from three measured models and not measured; if a different object is cheaper or exercises more clauses — E6's twelve-colour
map as written (`plans/FS131-E6-derivation.md` §§ 3.1–3.3), a map built from `sixFrag`, a general "overlay" lemma — take it and say why. If a hypothesis
set resists every model you try, stop on it and message me: that is the finding this rule exists to catch. The list is long for one plan: order it
by what rests on each theorem (the four moves first, then the stuck vertex, then E7's four, then the bends), and say where a second planning pass
should take over if one does not hold it all. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.
