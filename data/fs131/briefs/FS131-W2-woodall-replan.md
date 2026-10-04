# Brief FS131-W2 — Woodall's chain re-planned: E1-NO45 in place of the two open steps

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-W2
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: the successor of FS131-W on Woodall's chain — replace the two open leaves `step5_eq` and `step7` by FS131-E1's lemmas, stated over `ArcMap` with `sorry` at every leaf, decide how E1-NOBRANCH's Jordan curve theorem enters, plan each new leaf, and bring the implementer's handoff current
  launch: now, in the Opus slot FS131-E1 freed, beside FS131-I2e and FS131-I3e (implementers), FS131-K2d (a planner) and EXT-HN1 (an outside audit), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a step of E1's argument that fails when formalized, a statement defect, a generalization, a missing lemma, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-W2.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building before your first build
  record: `plans/FS131-W-kernel-plan.md` (on branch `fs131-ww`; you add stages to it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-ww` (branch `fs131-ww`): the modules under `Proofs/HadwigerNelson/Plane/Woodall/` and new ones beside them, supporting lemmas in the foundation modules (statements of other waves unchanged), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `plans/FS131-W-kernel-plan.md`, `tools/fs131_w2_*.py`, `data/fs131/w2/`, `data/fs131/reports/FS131-W2.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 480k

Hello. You are picking up the formal plan for "maps need six" — every five-colour map colouring of the plane has two points at distance exactly 1 in one
colour, almost everywhere (Woodall 1973, Thm 6, repaired) — from FS131-W (de Bruijn on Opus, like you). W stated the chain over `ArcMap` (maps whose
boundaries are locally finitely many segments and circular arcs) in `Plane/Woodall/Basic`, `Collar` and `Steps`, planned 29 of its 31 leaves, and found
two steps of the printed proof that do not hold as written: step 5 at an angle of exactly π/3 (F1) and step 7's terminal corner (F2). Those became the
open leaves `step5_eq` and `step7`. A deriver, FS131-E1 (Ephodos on Opus), has since bypassed both with one new lemma, and your job is to put its argument
into the plan in their place.

## Why this job

"Maps need six, almost everywhere" is what route M's reduction of `χ_m⁰(ℝ²) ≥ 6` rests on (wave 9), and until today it stood on two broken steps. With
E1's lemma it can be stated and planned with no open leaf, so the chain can land unconditionally, as the ruling written before E1 reported says:

> waits for FS131-E1. If E1 closes the GAPs, the chain lands unconditionally; if not, it lands with the open steps as named propositions — hypotheses of
> — source: plans/FS131-close-inventory.md

(that ruling is item 98; E1's report is items 106–107, which also record that E1-NO45 stands at one mind, and that Kooshi has been asked whether a blind
second mind runs before you formalize it — the default, Workflow 3.1's, is that the kernel is the second check, so you proceed either way.)

## The statements

The lemma that replaces both open steps:

> in a five-colour almost-everywhere-proper arc map in Woodall's normal form, no point lies on the boundary of exactly four or exactly five sectors
> — source: plans/FS131-E1-derivation.md § 3.6 The theorem

The chain's last step, which needs the Jordan curve theorem for curves made of segments and arcs:

> in an almost-everywhere-proper arc map satisfying (N1), with any finite number of colours, some point lies on the boundary of three or more sectors
> — source: plans/FS131-E1-derivation.md § 3.7 A map with no branch point

And the chain restored:

> no five-colour almost-everywhere-proper arc map in Woodall's normal form exists
> — source: plans/FS131-E1-derivation.md § 3.8 The chain, restored for arc maps

E1's handoff for the plan:

> de Bruijn — replaces the open leaves `step5_eq` and `step7` (and the held step 8, which is no longer needed) of FS106-AE-MAP6 over ArcMap: AE-MAP6 = steps 1–3, strict step 5, step 6, E1-NO45, E1-NOBRANCH; crosses with E1-SEE, E1-RAY, E1-CROSS, E1-COVER, E1-BAD as its lemmas
> — source: plans/FS131-E1-derivation.md § 3.6 The theorem

> de Bruijn — the last step of FS106-AE-MAP6 over ArcMap; it needs the Jordan curve theorem for arc curves, which W's representation ruling (inventory item 89) noted Mathlib lacks — price it, or route around it by W's collar machinery
> — source: plans/FS131-E1-derivation.md § 3.7 A map with no branch point

The row statements (`aeMap6`, `aeMap6_of_condition5`, `woodall_thm6`, `townsend_lemma`, `woodall_step4`) do not change in this job: only the leaves
beneath them do.

## Done means

1. **Your readback first**: check every quotation above against its source; restate in your record the chain as E1 restores it and the leaves W planned
   (§ 4.5) that stay, go, or change. Build the worktree once as W left it (`7aaaf2c4`). Commit and push.
2. **E1's argument read line by line** (`plans/FS131-E1-derivation.md` §§ 3.0–3.8, with the controls it names), as the mind that has to formalize it. A step
   that does not survive formalization — a case the hand argument skips, a hypothesis it uses silently, a count that fails — is a finding: message me at
   once with the step and why. E1's two caveats for the formal statement are yours to check against W's definitions: the normal form's (N1) must hold per
   sector (distinct colours on the sectors at every boundary point), and the argument reads the arc-map form at three places (§ 3.6's *not claimed*).
3. **The skeleton changed**: `step5_eq` and `step7` (and whatever served only step 8) removed; E1-SEE, E1-RAY, E1-CROSS, E1-COVER, E1-BAD, E1-NO45 and
   E1-NOBRANCH stated over `ArcMap` with `sorry` at every leaf, each read back against its E1 entry; `aeMap6` re-pointed at them. Building through the
   worktree's `./scripts/build.sh` with only `sorry` warnings; `tools/check_architecture.py` exit 0; `scripts/Axioms.lean` records added and removed to match.
4. **The Jordan curve theorem for segment-and-arc curves, decided** (`LEAN.md` § Assumptions): formalized here (priced), an `axiom` with its four items, a
   job of its own, or E1-NOBRANCH re-argued in W's collar language so that it is not needed — with the reason for the choice.
5. **A plan per new leaf** (route, Mathlib lemmas confirmed with `#check` at the pin, children, an honest price), a fresh `debruijn-obligation-modeling` pass
   over the new part, and **the handoff** (§ 4.7's form) brought current, so the chain's implementer can start from it.
6. Your stages appended to the record headed "Stage n — SAVED" from the next number, with "Theorems this phase proved" (usually none); the report in
   standing rule 11's form. If your context runs short, save the statements and their read-backs first and hand back with the rest named.

## What is yours to decide

The representation of each new lemma, the module layout, the order, whether E1's lemmas are best stated as E1 states them or merged (each must still be
read back to a declaration), and the Jordan decision. A widening is a generalization: message me. If the formal form of E1-NO45 needs a hypothesis E1's
argument hid, or a definition of W's turns out to say something different from E1's setting (§ 3.0), message me at once.

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them (inventory ruling 5), and
several trees are building today, so on exit 75 wait ten minutes and retry. `lake env lean` is for iteration only. The worktree's `.lake/packages` is a
symlink to the main tree's and its `.lake/build` its own copy; never replace that copy with a symlink. Nothing with a `sorry` reaches `main`; the chain
lands after waves 3 and 4, by merging `main` and its implementer's gate. You start no agents of your own (standing rule 1).
